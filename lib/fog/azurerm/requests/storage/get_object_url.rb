module Fog
  module Storage
    class AzureRM
      # This class provides the actual implemention for service calls.
      class Real
        # Get a public blob url from Azure blob storage
        # This is to make this library compatible with CarrierWave.
        def get_object_url(container_name, blob_name, expires)
          get_blob_https_url(container_name, blob_name, expires)
        end
      end

      # This class provides the mock implementation for unit tests.
      class Mock
        def get_object_url(container_name, blob_name, expires)
          get_blob_https_url(container_name, blob_name, expires)
        end
      end
    end
  end
end
