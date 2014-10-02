module NuOrderServices
  class Product < Base
    def find(id)
      nuorder.get("/api/product/#{id}")
    end

    def create!(data)
      nuorder.put('/api/product/new', data)
    end

    def update!(id, data)
      nuorder.post("/api/product/#{id}", data)
    end
  end
end
