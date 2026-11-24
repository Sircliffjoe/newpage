require 'rails_helper'

RSpec.describe "Testimonials", type: :request do
  describe "GET /testimonials" do
    it "returns http success" do
      get testimonials_path
      expect(response).to have_http_status(:success)
    end
  end
end
