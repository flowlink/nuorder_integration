module Wombat
  class Payment
    include Virtus.model(strict: true)

    attribute :number, Integer
    attribute :status, String
    attribute :amount, Integer
    attribute :payment_method, String
  end
end
