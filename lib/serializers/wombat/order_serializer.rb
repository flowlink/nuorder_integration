module Serializers
  module Wombat
    class OrderSerializer
      def self.serialize(wombat_order)
        output = {}
        wombat_order.attributes.each do |key, value|
          if value.respond_to?(:to_hash)
            output[key] = value.to_hash
          elsif value.kind_of?(Enumerable)
            output[key] = value.map do |nested_element|
              if nested_element.respond_to?(:to_hash)
                nested_element.to_hash
              else
                nested_element
              end
            end
          else
            output[key] = value
          end
        end
        output
      end
    end
  end
end
