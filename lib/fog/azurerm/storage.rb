module Fog
  module Storage
    # This class registers models, requests and collections
    class AzureRM < Fog::Service
      # Recognizes when creating management client
      recognizes :tenant_id
      recognizes :client_id
      recognizes :client_secret
      recognizes :subscription_id
      recognizes :environment

      # Recognizes when creating data client
      recognizes :azure_storage_account_name
      recognizes :azure_storage_access_key
      recognizes :azure_storage_domain

      recognizes :debug

      request_path 'fog/azurerm/requests/storage'
      # Azure Storage Container requests
      request :create_container
      request :release_container_lease
      request :acquire_container_lease
      request :delete_container
      request :list_containers
      request :put_container_metadata
      request :get_container_properties
      request :get_container_acl
      request :put_container_acl
      request :get_container_url
      request :check_container_exists
      # Azure Storage Blob requests
      request :list_blobs
      request :put_blob_metadata
      request :put_blob_properties
      request :get_blob_properties
      request :copy_blob
      request :copy_object
      request :copy_blob_from_uri
      request :compare_container_blobs
      request :acquire_blob_lease
      request :release_blob_lease
      request :delete_blob
      request :get_blob
      request :get_blob_url
      request :get_object_url
      request :get_blob_http_url
      request :get_blob_https_url
      request :create_block_blob
      request :put_blob_block
      request :put_blob_https_url
      request :put_object_url
      request :delete_blob_https_url
      request :delete_object_url
      request :commit_blob_blocks
      request :create_page_blob
      request :put_blob_pages
      request :wait_blob_copy_operation_to_finish
      request :save_page_blob
      request :multipart_save_block_blob

      model_path 'fog/azurerm/models/storage'
      model :directory
      collection :directories
      model :file
      collection :files

      # This class provides the mock implementation for unit tests.
      class Mock
        def initialize(_options = {})
          begin
            require 'azure/storage/common'
            require 'azure/storage/blob'
          rescue LoadError => e
            retry if require('rubygems')
            raise e.message
          end
        end
      end

      # This class provides the actual implementation for service calls.
      class Real
        def initialize(options)
          begin
            require 'azure/storage/common'
            require 'azure/storage/blob'
            require 'securerandom'
            @debug = ENV['DEBUG'] || options[:debug]
            require 'azure/core/http/debug_filter' if @debug
          rescue LoadError => e
            retry if require('rubygems')
            raise e.message
          end

          options[:environment] = 'AzureCloud' if options[:environment].nil?

          @tenant_id = options[:tenant_id]
          @client_id = options[:client_id]
          @client_secret = options[:client_secret]
          @subscription_id = options[:subscription_id]
          @environment = options[:environment]

          credentials = Fog::Credentials::AzureRM.get_credentials(@tenant_id, @client_id, @client_secret, @environment)
          telemetry = "gitlab-fog-azure-rm/#{Fog::AzureRM::VERSION}"

          return unless @azure_storage_account_name != options[:azure_storage_account_name] ||
                        @azure_storage_access_key != options[:azure_storage_access_key]

          @azure_storage_account_name = options[:azure_storage_account_name]
          @azure_storage_access_key = options[:azure_storage_access_key]
          @azure_storage_domain = options[:azure_storage_domain]

          domain =
            if @azure_storage_domain.nil? || @azure_storage_domain.empty?
              get_blob_endpoint(@azure_storage_account_name, true, @environment)
            else
              get_blob_endpoint_with_domain(@azure_storage_account_name, true, @azure_storage_domain)
            end

          azure_client = Azure::Storage::Common::Client.create(storage_account_name: @azure_storage_account_name,
                                                               storage_access_key: @azure_storage_access_key,
                                                               storage_blob_host: domain)
          @blob_client = Azure::Storage::Blob::BlobService.new(client: azure_client)
          @blob_client.with_filter(Azure::Storage::Common::Core::Filter::ExponentialRetryPolicyFilter.new)
          @blob_client.with_filter(Azure::Core::Http::DebugFilter.new) if @debug
          @signature_client = Azure::Storage::Common::Core::Auth::SharedAccessSignature.new(@azure_storage_account_name,
                                                                                            @azure_storage_access_key)
        end
      end
    end
  end
end
