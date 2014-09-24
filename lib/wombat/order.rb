module Wombat
  # https://support.wombat.co/hc/en-us/articles/202555780-Orders
  class Order

    class Address
      include Virtus.model(strict: true)

      attribute :firstname, String
      attribute :lastname, String, default: ''
      attribute :address1, String
      attribute :address2, String, default: ''
      attribute :zipcode, String
      attribute :city, String
      attribute :state, String, default: ''
      attribute :country, String
      attribute :phone, String
    end

    class Adjustment
      include Virtus.model(strict: true)

      attribute :name, String
      attribute :value, Integer
    end

    class LineItem
      include Virtus.model(strict: true)

      # Unique identifier of product
      attribute :product_id, String
      # Product’s name
      attribute :name, String
      # Quantity ordered
      attribute :quantity, Integer
      # Price per item
      attribute :price, Integer
    end


    # https://support.wombat.co/hc/en-us/articles/202555780-Orders#ordertotalobjectattributes
    class OrderTotal
      include Virtus.model(strict: true)

      # Total of price * quantity for all line items
      attribute :item, Integer
      # Total of all adjustment values
      attribute :adjustment, Integer, default: ->(this, _) { this.tax + this.shipping }
      # Total of tax adjustment values
      attribute :tax, Integer
      # Total of shipping adjustment values
      attribute :shipping, Integer
      # Total of all payments for this order
      attribute :payment, Integer, default: ->(this, _) { this.item + this.adjustment }
      # Overall total of order
      attribute :order, Integer, default: ->(this, _) { this.payment }
    end

    class Payment
      include Virtus.model(strict: true)

      attribute :number, Integer
      attribute :status, String
      attribute :amount, Integer
      attribute :payment_method, String
    end

    class Retailer
      include Virtus.model(strict: true)

      attribute :retailer_name, String
      attribute :retailer_code, String
      attribute :buyer_name, String
    end

    include Virtus.model(strict: true)

    # Unique identifier for the order
    attribute :id, String
    # Nuorder internal id of order
    attribute :nuorder_id, String
    # Current order status
    attribute :status, String
    # Location where order was placed
    attribute :channel, String
    # Customers email address
    attribute :email, String
    # Currency ISO code
    attribute :currency, String
    # Date & time order was placed (ISO format)
    attribute :placed_on, String
    # Order value totals
    attribute :totals, OrderTotal
    # Nuorder specific, missing in official wombat docs
    attribute :rep_name, String
    # Nuorder specific, missing in official wombat docs
    attribute :rep_code, String
    # Nuorder specific, missing in official wombat docs
    attribute :retailer, Retailer
    # Array of the orders line items
    attribute :line_items, Array[LineItem]
    # Array ot the orders adjustments
    attribute :adjustments, Array[Adjustment]
    # Customers shipping address
    attribute :shipping_address, Address
    # Customers billing address
    attribute :billing_address, Address
    # Array of the order’s payments
    attribute :payments, Array[Payment]
  end
end
