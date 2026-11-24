require 'rails_helper'

RSpec.describe "Faqs", type: :request do
  describe "GET /faq" do
    it "returns http success" do
      get faqs_path
      expect(response).to have_http_status(:success)
    end
  end
end
