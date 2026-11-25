require "rails_helper"

RSpec.describe Award, type: :model do
  describe "validations" do
    it "is valid with required attributes" do
      award = described_class.new(
        title: "Travel Agency of the Year",
        recipient_type: :company,
        recipient_name: "NewPage Integrity Travels & Tours Limited",
        issuing_organization: "NANTA Eastern Zone",
        awarded_on: Date.new(2026, 11, 21)
      )
      expect(award).to be_valid
    end

    it "requires title, recipient_name, and issuing_organization" do
      award = described_class.new
      expect(award).not_to be_valid
      expect(award.errors[:title]).to be_present
      expect(award.errors[:recipient_name]).to be_present
      expect(award.errors[:issuing_organization]).to be_present
    end
  end

  describe "enums and helpers" do
    it "supports company and founder recipient types" do
      company_award = described_class.new(recipient_type: :company)
      founder_award = described_class.new(recipient_type: :founder)

      expect(company_award.recipient_label).to eq("Company Award")
      expect(founder_award.recipient_label).to eq("Founder & CEO")
    end
  end
end
