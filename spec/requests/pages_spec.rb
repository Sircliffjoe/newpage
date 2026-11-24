require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get about_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /visa-information" do
    it "returns http success" do
      get visa_information_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /study-abroad" do
    it "returns http success" do
      get study_abroad_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /cac-services" do
    it "returns http success" do
      get cac_services_path
      expect(response).to have_http_status(:success)
    end
  end
end
