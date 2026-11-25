require "rails_helper"

RSpec.describe "Awards", type: :request do
  include Devise::Test::IntegrationHelpers

  let!(:company_award) do
    Award.create!(
      title: "Travel Agency of the Year",
      recipient_type: :company,
      recipient_name: "NewPage Integrity Travels & Tours Limited",
      issuing_organization: "NANTA Eastern Zone",
      awarded_on: Date.new(2026, 11, 21),
      published: true,
      featured: true
    )
  end

  let!(:founder_award) do
    Award.create!(
      title: "Fellowship of the African Institute of Public Leadership",
      recipient_type: :founder,
      recipient_name: "Mrs. Ify Adegoke",
      issuing_organization: "AIPL",
      awarded_on: Date.new(2026, 11, 14),
      published: true,
      featured: true
    )
  end

  describe "GET /awards" do
    it "renders published awards and supports recipient_type filtering" do
      get awards_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Travel Agency of the Year")
      expect(response.body).to include("Fellowship of the African Institute of Public Leadership")

      get awards_path(recipient_type: "founder")
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Mrs. Ify Adegoke")
      expect(response.body).not_to include("Travel Agency of the Year")
    end
  end

  describe "Admin CRUD /admin/awards" do
    let(:admin) do
      User.create!(
        email: "awards-admin@example.com",
        password: "password123",
        password_confirmation: "password123",
        first_name: "Admin",
        last_name: "User",
        role: :super_admin
      )
    end

    before { sign_in admin }

    it "allows admin to list, create, update, and delete awards" do
      get admin_awards_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Travel Agency of the Year")

      expect do
        post admin_awards_path, params: {
          award: {
            title: "Excellence in Tourism Award",
            recipient_type: "company",
            recipient_name: "NewPage Integrity Travels & Tours Limited",
            issuing_organization: "Delta Tourism Board",
            awarded_on: "2026-10-01",
            published: true
          }
        }
      end.to change(Award, :count).by(1)
      expect(response).to redirect_to(admin_awards_path)

      created = Award.find_by!(title: "Excellence in Tourism Award")

      patch admin_award_path(created), params: { award: { title: "Excellence in Global Tourism Award" } }
      expect(response).to redirect_to(admin_awards_path)
      expect(created.reload.title).to eq("Excellence in Global Tourism Award")

      expect do
        delete admin_award_path(created)
      end.to change(Award, :count).by(-1)
      expect(response).to redirect_to(admin_awards_path)
    end
  end
end
