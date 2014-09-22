module Wombat
  class Address
    include Virtus.model(strict: true)

    attribute :firstname, String
    attribute :lastname, String
    attribute :address1, String
    attribute :address2, String
    attribute :zipcode, String
    attribute :city, String
    attribute :state, String
    attribute :country, String
    attribute :phone, String
  end
end
