require 'rails_helper'

RSpec.describe "Galleries", type: :request do
  describe "GET /gallery" do
    it "returns http success" do
      get gallery_path
      expect(response).to have_http_status(:success)
    end
  end
end
