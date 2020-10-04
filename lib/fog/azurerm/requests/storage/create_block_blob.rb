module Fog
  module Storage
    class AzureRM
      # This class provides the actual implementation for service calls.
      class Real
        def create_block_blob(container_name, blob_name, body, options = {})
          options[:request_id] = SecureRandom.uuid
          msg = "create_block_blob #{blob_name} to the container #{container_name}. options: #{options}"
          Fog::Logger.debug msg

          @blob_client.create_block_blob(container_name, blob_name, body, options)
        rescue Azure::Core::Http::HTTPError => ex
          raise_azure_exception(ex, msg)
        end
      end

      # This class provides the mock implementation for unit tests.
      class Mock
        def create_block_blob(_container_name, _blob_name, body, _options = {})
          Fog::Logger.debug 'Blob created successfully.'
          if body.nil?
            {
              'name' => 'test_blob',
              'metadata' => {},
              'properties' => {
                'last_modified' => 'Mon, 04 Jul 2016 02:50:20 GMT',
                'etag' => '0x8D3A3B5F017F52D',
                'lease_status' => nil,
                'lease_state' => nil,
                'content_length' => 0,
                'content_type' => 'application/octet-stream',
                'content_encoding' => nil,
                'content_language' => nil,
                'content_disposition' => nil,
                'content_md5' => nil,
                'cache_control' => nil,
                'sequence_number' => 0,
                'blob_type' => 'BlockBlob',
                'copy_id' => nil,
                'copy_status' => nil,
                'copy_source' => nil,
                'copy_progress' => nil,
                'copy_completion_time' => nil,
                'copy_status_description' => nil,
                'accept_ranges' => 0
              }
            }
          else
            {
              'name' => 'test_blob',
              'metadata' => {},
              'properties' => {
                'last_modified' => 'Mon, 04 Jul 2016 02:50:20 GMT',
                'etag' => '0x8D3A3B5F017F52D',
                'lease_status' => 'unlocked',
                'lease_state' => 'available',
                'content_length' => 4_194_304,
                'content_type' => 'application/octet-stream',
                'content_encoding' => nil,
                'content_language' => nil,
                'content_disposition' => nil,
                'content_md5' => 'tXAohIyxuu/t94Lp/ujeRw==',
                'cache_control' => nil,
                'sequence_number' => 0,
                'blob_type' => 'BlockBlob',
                'copy_id' => '095adc3b-e277-4c3d-97e0-0abca881f60c',
                'copy_status' => 'success',
                'copy_source' => 'https://testaccount.blob.core.windows.net/test_container/test_blob?snapshot=2016-02-04T08%3A35%3A50.3256874Z',
                'copy_progress' => '4194304/4194304',
                'copy_completion_time' => 'Thu, 04 Feb 2016 08:35:52 GMT',
                'copy_status_description' => nil,
                'accept_ranges' => 0
              }
            }
          end
        end
      end
    end
  end
end
