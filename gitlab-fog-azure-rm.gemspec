lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fog/azurerm/version'

Gem::Specification.new do |spec|
  spec.name          = 'gitlab-fog-azure-rm'
  spec.version       = Fog::AzureRM::VERSION
  spec.authors       = ['Shaffan Chaudhry', 'Samawia Moin', 'Adnan Khalil', 'Zeeshan Arshad', 'Haider Ali', 'Waqar Haider', 'Bilal Naeem', 'Muhammad Asad', 'Azeem Sajid', 'Maham Nazir', 'Abbas Sheikh']
  spec.summary       = "Module for the 'fog' gem to support Azure Blob Storage with CarrierWave and Fog."
  spec.description   = "This is a stripped-down fork of fog-azure-rm that enables Azure Blob Storage to be used with CarrierWave and Fog."
  spec.files = `git ls-files`.split("\n")
  spec.test_files = `git ls-files -- {spec,tests}/*`.split("\n")
  spec.require_paths = %w[lib]
  spec.license  = 'MIT'
  spec.homepage = 'https://gitlab.com/gitlab-org/gitlab-fog-azure-rm'
  spec.rdoc_options = %w[--charset=UTF-8]
  spec.extra_rdoc_files = %w[README.md]
  spec.required_ruby_version = '>= 2.0.0'
  spec.post_install_message = 'Thanks for installing!'
  spec.add_development_dependency 'codeclimate-test-reporter' , '~> 1.0.0'
  spec.add_development_dependency 'minitest', '~> 5.8.4'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 0.89'
  spec.add_development_dependency 'simplecov'
  spec.add_dependency 'azure-storage-blob', '~> 2.0'
  spec.add_dependency 'azure-storage-common', '~> 2.0'
  spec.add_dependency 'fog-core', '= 2.1.0'
  spec.add_dependency 'fog-json', '~> 1.2.0'
  spec.add_dependency 'mime-types'
  spec.add_dependency 'ms_rest_azure', '~> 0.12.0'
end
