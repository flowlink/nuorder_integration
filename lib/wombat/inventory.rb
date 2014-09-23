module Wombat
  # https://support.wombat.co/hc/en-us/articles/202535230
  class Inventory
    include Virtus.model(strict: true)

    # Unique identifier for the inventory
    attribute :id, String
    # Unique identifier of product
    attribute :product_id, String
    # Nuorder specific, not present in official wombat API
    attribute :nuorder_id, String
    # Quantity in stock
    attribute :quantity, Integer
    # Unique indentifier for the stock location
    attribute :location, String
  end
end

