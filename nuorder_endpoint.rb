require 'sinatra'
require 'sinatra/reloader' if development?
require 'endpoint_base'
require 'nuorder_integration'

class NuorderEndpoint < EndpointBase::Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  enable :logging

  post '/get_orders' do
    begin
      order_service = NuOrderServices::Order.new(@config)
      orders = order_service.all(['edited', 'approved'])
      orders.map! { |nuorder_order| Wombat::OrderBuilder.new(nuorder_order).build }
      orders.each { |order| add_object :order, Wombat::OrderSerializer.serialize(order) }
      order_service.process!(orders.map(&:nuorder_id))
      result 200
    rescue Exception => e
      log_exception(e)
      result 500, e.message
    end
  end

  post '/cancel_order' do
    begin
      NuOrderServices::Order.new(@config).cancel!(@payload[:nuorder_id])
      set_summary "Order has been cancelled in NuOrder"
      result 200
    rescue Exception => e
      log_exception(e)
      result 500, e.message
    end
  end
end

