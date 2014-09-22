module Wombat
  # https://support.wombat.co/hc/en-us/articles/202555780-Orders#ordertotalobjectattributes
  class OrderTotal
    include Virtus.model(strict: true)

    # Total of price * quantity for all line items
    attribute :item, Integer
    # Total of all adjustment values
    attribute :adjustment, Integer
    # Total of tax adjustment values
    attribute :tax, Integer
    # Total of shipping adjustment values
    attribute :shipping, Integer
    # Total of all payments for this order
    attribute :payment, Integer
    # Overall total of order
    attribute :order, Integer
  end
end
