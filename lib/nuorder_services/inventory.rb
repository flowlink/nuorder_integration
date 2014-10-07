module NuOrderServices
  class Inventory < Base
    def update_inventory!(id, data)
      nuorder.post("/api/inventory/external_id/#{id}", data)
    end
  end
end
