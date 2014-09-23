module Wombat
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
end
