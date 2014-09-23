module NuOrderServices
  class Product
    def find(id)
      nuorder.get("/api/product/#{id}")
    end
  end
end
