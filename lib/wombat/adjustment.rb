module Wombat
  class Adjustment
    include Virtus.model(strict: true)

    attribute :name, String
    attribute :value, Integer
  end
end
