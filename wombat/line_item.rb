module Wombat
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
end
