# NewPage Integrity Travels & Tours Limited

Production Ruby on Rails 8 web platform, Lead CRM, and full Content Management System (CMS) for **NewPage Integrity Travels & Tours Limited** (`newpageintegritytravels.com`).

## Core Capabilities
- **Public Website**: Home, About (with dynamic Team), Travel & Tours, Visa Assistance, Study Abroad, CAC & Corporate Services, Destinations, Photo Gallery (with Lightbox), Testimonials, Blog/News, FAQs, Sitewide Search, Newsletter Signup, Contact & Consultation forms, and Floating WhatsApp CTA.
- **Full Management Center CMS (`/admin`)**:
  - **Site Pages & Hero Banners**: Upload and replace hero images, secondary images, headlines, stats, office address, WhatsApp number, and SEO metadata for every page.
  - **Content Hub**: Full CRUD + ActiveStorage image uploads + ActionText/Trix rich-text editor for Services, Destinations, Blog Posts, Categories, FAQs, Testimonials, Team Members, and Photo Gallery.
  - **Leads & CRM**: Filterable leads, status updates, internal consultant notes, and CSV export.
  - **Admin Email Center (Brevo API)**: Compose and send individual or bulk emails to Leads, Visa/Study Abroad prospects, Contact senders, or Newsletter Subscribers with full delivery logging.
  - **Role-Based Access**: Super Admin, Content Editor, and Staff roles.

## Local Setup
```bash
bundle install
bin/rails db:prepare
bin/rails db:seed
bin/dev
```
Default admin login (change immediately in production):
- **URL**: `/admin`
- **Email**: `admin@newpageintegrity.com`
- **Password**: `password123`

## Brevo API Setup
1. Sign in to [Brevo](https://app.brevo.com) and verify your sender domain (`newpageintegritytravels.com`).
2. Generate an API key under **SMTP & API → API Keys**.
3. Set `BREVO_API_KEY`, `BREVO_SENDER_EMAIL`, and `ADMIN_NOTIFICATION_EMAIL` in `.kamal/secrets` (see `.env.example`).

## Contabo VPS Deployment (Kamal — `169.58.122.43`)
1. Point DNS `A` records for `newpageintegritytravels.com` and `www.newpageintegritytravels.com` to `169.58.122.43`.
2. Configure `.kamal/secrets` with `RAILS_MASTER_KEY`, `NEWPAGE_DATABASE_PASSWORD`, `POSTGRES_PASSWORD`, `BREVO_API_KEY`, `KAMAL_REGISTRY_USERNAME`, and `KAMAL_REGISTRY_PASSWORD`.
3. Run first-time setup & deploy:
```bash
bin/kamal setup
bin/kamal app exec "bin/rails db:seed"
```
4. Future deploys:
```bash
bin/kamal deploy
```
Uploaded ActiveStorage images are persisted in the Docker volume `newpage_storage:/rails/storage`.
