module NuOrderServices
  class Inventory < Base
    def update_inventory(id, data)
      nuorder.post("/api/inventory/#{id}", data)
    end
  end
end
