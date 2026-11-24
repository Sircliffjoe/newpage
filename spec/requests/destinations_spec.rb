require 'rails_helper'

RSpec.describe "Destinations", type: :request do
  describe "GET /destinations" do
    it "returns http success" do
      get destinations_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destinations/:slug" do
    it "returns http success" do
      destination = Destination.create!(
        name: "United Kingdom",
        country_code: "GB",
        category: :study,
        cost_estimate: "£12,000",
        published: true
      )

      get destination_path(slug: destination.slug)
      expect(response).to have_http_status(:success)
    end
  end
end
