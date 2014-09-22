module Wombat
  class Retailer
    include Virtus.model(strict: true)

    attribute :retailer_name, String
    attribute :retailer_code, String
    attribute :buyer_name, String
  end
end
