require 'rails_helper'

RSpec.describe "Services", type: :request do
  describe "GET /services" do
    it "returns http success" do
      get services_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /services/:slug" do
    it "returns http success" do
      service = Service.create!(
        title: "Flight Ticketing",
        category: :travel,
        short_description: "Domestic and international flight bookings",
        published: true
      )

      get service_path(slug: service.slug)
      expect(response).to have_http_status(:success)
    end
  end
end
