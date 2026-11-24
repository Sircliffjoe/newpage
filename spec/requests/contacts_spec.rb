require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  describe "GET /contact" do
    it "returns http success" do
      get contact_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /contact" do
    it "creates a contact submission and redirects" do
      expect {
        post contacts_path, params: {
          contact_submission: {
            name: "Adaeze Okafor",
            email: "adaeze@example.com",
            phone: "08031234567",
            subject: "General Inquiry",
            message: "Please share your office hours."
          }
        }
      }.to change(ContactSubmission, :count).by(1)

      expect(response).to have_http_status(:redirect)
    end
  end
end
