require "rails_helper"

RSpec.describe "NewPage Integrity Platform & CMS", type: :request do
  let!(:admin) do
    User.create!(
      email: "superadmin@newpageintegrity.com",
      password: "password123",
      password_confirmation: "password123",
      first_name: "Super",
      last_name: "Admin",
      role: :super_admin
    )
  end

  let!(:page_home) { PageSetting.create!(key: "home", page_name: "Home Page", hero_title: "Global Travel") }
  let!(:service) { Service.create!(title: "UK Visa Support", category: :visa, short_description: "Fast visa help", published: true) }
  let!(:destination) { Destination.create!(name: "Canada", country_code: "CA", category: :study, cost_estimate: "$15,000 CAD", published: true) }
  let!(:category) { BlogCategory.create!(name: "Visa Updates") }
  let!(:post_record) { BlogPost.create!(title: "Canada Visa Guide", blog_category: category, author: admin, status: :published, excerpt: "Guide") }
  let!(:faq) { Faq.create!(question: "How long does it take?", answer: "3 weeks", category: :visas, published: true) }
  let!(:testimonial) { Testimonial.create!(client_name: "John Doe", content: "Great service!", rating: 5, service_type: :visa, published: true) }
  let!(:team_member) { TeamMember.create!(name: "Jane Smith", role: "Director", bio: "Expert", published: true) }

  describe "Public pages" do
    it "renders all core public pages successfully" do
      [
        root_path,
        about_path,
        visa_information_path,
        study_abroad_path,
        cac_services_path,
        services_path,
        service_path(slug: service.slug),
        destinations_path,
        destination_path(slug: destination.slug),
        blog_path,
        blog_post_path(slug: post_record.slug),
        gallery_path,
        testimonials_path,
        faqs_path,
        contact_path,
        privacy_policy_path,
        terms_of_service_path,
        search_path(q: "Canada")
      ].each do |path|
        get path
        expect(response).to have_http_status(:ok), "Expected 200 OK for #{path}, got #{response.status}"
      end
    end

    it "creates a ContactSubmission and Lead on contact form post" do
      expect {
        post contacts_path, params: {
          contact_submission: {
            name: "Chinedu Eze",
            email: "chinedu@example.com",
            phone: "08031234567",
            subject: "Canada Visa Consultation",
            message: "I need help with a tourist visa."
          }
        }
      }.to change(ContactSubmission, :count).by(1).and change(Lead, :count).by(1)

      expect(Lead.last.service_type).to eq("visa")
    end

    it "subscribes an email to the newsletter" do
      expect {
        post newsletter_subscribers_path, params: { newsletter_subscriber: { email: "traveler@example.com" } }
      }.to change(NewsletterSubscriber, :count).by(1)
    end
  end

  describe "Admin CMS & Email Center" do
    before do
      post user_session_path, params: { user: { email: admin.email, password: "password123" } }
    end

    it "renders all admin CMS index pages cleanly" do
      [
        admin_root_path,
        admin_leads_path,
        admin_contact_submissions_path,
        admin_newsletter_subscribers_path,
        admin_services_path,
        admin_destinations_path,
        admin_blog_posts_path,
        admin_blog_categories_path,
        admin_faqs_path,
        admin_testimonials_path,
        admin_gallery_images_path,
        admin_team_members_path,
        admin_page_settings_path,
        admin_emails_path,
        new_admin_email_path,
        admin_users_path
      ].each do |path|
        get path
        expect(response).to have_http_status(:ok), "Expected 200 OK for #{path}, got #{response.status}"
      end
    end

    it "sends and logs emails via BrevoMailerService in Admin Email Center" do
      expect {
        post admin_emails_path, params: {
          email: {
            recipients: "Adaeze Okafor <adaeze@example.com>\nclient2@example.com",
            contact_type: "lead",
            subject: "Visa Update",
            body: "Your consultation is confirmed."
          }
        }
      }.to change(Email, :count).by(2)

      expect(Email.sent.count).to eq(2)
    end

    it "adds internal notes to a lead" do
      lead = Lead.create!(name: "Test Client", email: "test@example.com", service_type: :visa)
      expect {
        post admin_lead_notes_path(lead), params: { note: { body: "Called client, passport verified." } }
      }.to change(Note, :count).by(1)
    end
  end
end
