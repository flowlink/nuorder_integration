class NuOrderServices::Company < NuOrderServices::Base
  def find(id)
    nuorder.get("/api/company/#{id}")
  end
end
