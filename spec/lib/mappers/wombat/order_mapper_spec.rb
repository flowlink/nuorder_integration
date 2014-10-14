require 'spec_helper'

describe Wombat::OrderMapper do
  include_examples 'config hash'
  let(:order_service) { NuOrderServices::Order.new(config) }
  let(:company_service) { NuOrderServices::Company.new(config) }

  it 'parses valid order successfully' do
    VCR.use_cassette('mappers/wombat/order') do
      response = order_service.all('pending')
      response.each do |order|
        company = company_service.find(order['retailer']['_id'])
        expect { described_class.new(order, company).build }.to_not raise_error
      end
    end
  end

  it 'does not parse invalid order' do
    VCR.use_cassette('mappers/wombat/order') do
      response = order_service.all('pending')
      response.each do |order|
        invalid_order = order.delete(:_id)
        company = company_service.find(order['retailer']['_id'])
        expect { described_class.new(invalid_order, company).build }.to raise_error
      end
    end
  end
end
