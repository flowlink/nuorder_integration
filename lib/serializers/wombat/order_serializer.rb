module Wombat
  class OrderSerializer
    def self.serialize(wombat_order)
      output = {}
      wombat_order.attributes.each do |key, value|
        output[key] = if value.respond_to?(:to_hash)
          value.to_hash
        elsif value.kind_of?(Enumerable)
          value.map do |element|
            element.respond_to?(:to_hash) ? element.to_hash : element
          end
        else
          value
        end
      end
      output
    end
  end
end
