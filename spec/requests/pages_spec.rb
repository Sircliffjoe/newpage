require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get "/pages/home"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get "/pages/about"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /visa_information" do
    it "returns http success" do
      get "/pages/visa_information"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /study_abroad" do
    it "returns http success" do
      get "/pages/study_abroad"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /cac_services" do
    it "returns http success" do
      get "/pages/cac_services"
      expect(response).to have_http_status(:success)
    end
  end

end
