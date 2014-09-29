$:.unshift File.dirname(__FILE__)

require 'nuorder_connector/connector'

require 'nuorder_services/base'
require 'nuorder_services/order'
require 'nuorder_services/product'

require 'models/wombat/order'
require 'builders/wombat/order_builder'
require 'serializers/wombat/order_serializer'

require 'models/nuorder/inventory'
require 'builders/nuorder/inventory_builder'

