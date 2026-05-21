require 'rails_helper'

RSpec.describe "Galleries", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/gallery/index"
      expect(response).to have_http_status(:success)
    end
  end

end
