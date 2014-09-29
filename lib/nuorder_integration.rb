$:.unshift File.dirname(__FILE__)

require 'nuorder_connector/connector'

require 'nuorder_services/base'
require 'nuorder_services/order'
require 'nuorder_services/product'

Dir[App.root.join("lib/models/**/*.rb")].each { |file| require file }
Dir[App.root.join("lib/builders/**/*.rb")].each { |file| require file }
Dir[App.root.join("lib/serializers/**/*.rb")].each { |file| require file }

