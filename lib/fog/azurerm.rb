require 'ms_rest_azure'
require 'azure/core/http/http_error'
require 'erb'
require 'fog/azurerm/config'
require 'fog/azurerm/constants'
require 'fog/azurerm/utilities/general'
require 'fog/azurerm/version'
require 'fog/core'
require 'fog/json'
require 'fog/azurerm/models/storage/sku_name'
require 'fog/azurerm/models/storage/sku_tier'
require 'fog/azurerm/models/storage/kind'

module Fog
  # Autoload Module for Credentials
  module Credentials
    autoload :AzureRM, File.expand_path('azurerm/credentials', __dir__)
  end

  # Autoload Module for Storage
  module Storage
    autoload :AzureRM, File.expand_path('azurerm/storage', __dir__)
  end

  # Main AzureRM fog Provider Module
  module AzureRM
    extend Fog::Provider
    service(:storage, 'Storage')
  end
end
