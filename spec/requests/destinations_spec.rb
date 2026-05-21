require 'rails_helper'

RSpec.describe "Destinations", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/destinations/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/destinations/show"
      expect(response).to have_http_status(:success)
    end
  end

end
