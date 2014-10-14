module Wombat
  class OrderMapper
    attr_reader :nuorder_order, :nuorder_company

    def initialize(order, company)
      @nuorder_order = order.dup.freeze
      @nuorder_company = company.dup.freeze
    end

    def build
      @order ||= Wombat::Order.new(
        id: nuorder_order['order_number'],
        nuorder_id: nuorder_order['_id'],
        status: 'complete',
        channel: 'nuorder',
        email: buyers_email,
        currency: nuorder_order['currency_code'],
        placed_on: nuorder_order['created_on'],
        totals: totals,
        rep_name: nuorder_order['rep_name'],
        rep_code: nuorder_order['rep_code'],
        retailer: retailer,
        line_items: line_items,
        adjustments: adjustments,
        shipping_address: shipping_address,
        billing_address: billing_address,
        payments: payments
      )
    rescue Virtus::CoercionError => e
      raise ArgumentError.new(
        "`#{e.attribute.name}` attribute type is #{e.output.class}, expected #{e.target_type}"
      )
    end

    private

    def buyer
      nuorder_company.fetch('user_connections', []).first || {}
    end

    def buyers_email
      buyer['email'] || ''
    end

    def buyers_phone
      buyer['phone_cell'] || buyer['phone_office'] || ''
    end

    def totals
      @totals ||= Wombat::Order::OrderTotal.new(
        item: line_items.reduce(0) do |total, item|
          total + (item.quantity*item.price)
        end,
        tax: 0, # TODO: where to get tax cost from?
        shipping: 0, # TODO: where to get shipping cost from?
      )
    end

    def retailer
      @retailer ||= Wombat::Order::Retailer.new(
        retailer_name: nuorder_retailer['retailer_name'],
        retailer_code: nuorder_retailer['retailer_code'],
        buyer_name: nuorder_retailer['buyer_name']
      )
    end

    def line_items
      @line_items ||= nuorder_order['line_items'].try(:map) do |line_item|
        price = 0
        quantity = 0
        line_item['sizes'].try(:each) do |size|
          price += size['price'].to_i
          quantity += size['quantity'].to_i
        end

        Wombat::Order::LineItem.new(
          product_id: line_item['upc'],
          name: 'Spree t-shirt', # TODO: make another api call to get it?
          quantity: quantity,
          price: price,
        )
      end
    end

    def adjustments
      # TODO: placeholders, nuroder does not have tax and shipping info in API
      @adjustments ||= [
        Wombat::Order::Adjustment.new(name: 'Tax', value: 0),
        Wombat::Order::Adjustment.new(name: 'Shipping', value: 0)
      ]
    end

    def shipping_address
      @shipping_address ||= Wombat::Order::Address.new(
        {
          firstname: customers_first_name,
          lastname: customers_last_name,
          address1: nuorder_shipping_address['line_1'],
          address2: nuorder_shipping_address['line_2'],
          zipcode: nuorder_shipping_address['zip'],
          city: nuorder_shipping_address['city'],
          state: nuorder_shipping_address['state'],
          country: nuorder_shipping_address['country'],
          phone: nuorder_shipping_address['phone']
        }.compact
      )
    end

    def billing_address
      @billing_address ||= Wombat::Order::Address.new(
        {
          firstname: customers_first_name,
          lastname: customers_last_name,
          address1: nuorder_billing_address['line_1'],
          address2: nuorder_billing_address['line_2'],
          zipcode: nuorder_billing_address['zip'],
          city: nuorder_billing_address['city'],
          state: nuorder_billing_address['state'],
          country: nuorder_billing_address['country'],
          phone: nuorder_billing_address['phone']
        }.compact
      )
    end

    def payments
      # This should be empty for now as nuorder does not have payments in API
      @payments ||= []
    end

    def split_customers_name
      nuorder_order.fetch('retailer', {})['buyer_name'].try(:split, ' ', 2)
    end

    def customers_first_name
      split_customers_name.try(:[], 0)
    end

    def customers_last_name
      split_customers_name.try(:[], 1)
    end

    def nuorder_shipping_address
      @nuroder_shipping_address ||= nuorder_order.fetch('shipping_address', {})
    end

    def nuorder_billing_address
      @nuorder_billing_address ||= nuorder_order.fetch('billing_address', {})
    end

    def nuorder_retailer
      @nuorder_retailer ||= nuorder_order.fetch('retailer', {})
    end
  end
end
