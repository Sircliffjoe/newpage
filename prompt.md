You are a senior Ruby on Rails architect and full-stack engineer.

Your task is to completely design and build a modern, scalable, production-ready website and business management platform for:

NEWPAGE INTEGRITY TRAVELS & TOURS LIMITED

The business operates as:

1. Travel & Tours Agency
2. Visa Assistance & Immigration Consulting
3. Study Abroad / Foreign Admission Consulting
4. Corporate Affairs & CAC Registration Consultancy

The website must be clean, modern, trustworthy, mobile-first, SEO-friendly, conversion-focused, and built ONLY with technologies within the Rails ecosystem.

==================================================
CORE TECH STACK (STRICT REQUIREMENT)
====================================

Backend:

* Ruby on Rails 8

Frontend:

* Rails Views (ERB)
* TailwindCSS
* StimulusJS
* Turbo (Hotwire)
* Importmaps ONLY (NO Webpack, NO Vite, NO esbuild)

Database:

* PostgreSQL (production)
* SQLite allowed in development

Authentication:

* Devise

Authorization:

* Pundit

File Uploads:

* ActiveStorage

Background Jobs:

* Solid Queue OR Sidekiq (prefer Rails-native where possible)

Caching:

* Solid Cache / Rails caching

Deployment:

* Kamal
* Docker

Web Server:

* Puma

Email:

* ActionMailer
* Resend OR Mailgun integration

Admin Dashboard:

* Build custom admin panel inside Rails
* DO NOT use ActiveAdmin unless absolutely necessary

Analytics:

* Google Analytics integration

Maps:

* Google Maps embed

SEO:

* Meta tags
* OpenGraph support
* Structured data
* Sitemap
* robots.txt

Forms:

* Rails native forms

Testing:

* RSpec
* FactoryBot
* Capybara

==================================================
DESIGN & UI REQUIREMENTS
========================

The current business flyers are visually outdated and overcrowded.

The new website must feel:

* Premium
* International
* Corporate
* Modern
* Trustworthy
* Fast
* Minimal but informative

Brand colors:

* Blue
* Red
* White

Use:

* Large hero sections
* Travel imagery
* Clean spacing
* Modern typography
* CTA sections
* Icon cards
* Rounded cards
* Soft shadows
* Responsive layouts

The website must work excellently on:

* Mobile
* Tablet
* Desktop

==================================================
WEBSITE STRUCTURE
=================

Build the following pages and sections:

---

1. HOME PAGE

---

Include:

* Hero section with CTA
* Intro to business
* Featured services
* Why choose us
* Travel destinations
* Visa assistance highlights
* Study abroad highlights
* CAC registration highlights
* Testimonials
* Stats/counters
* WhatsApp CTA
* Inquiry forms
* Newsletter signup
* Contact snippet
* Google map preview

Hero CTA buttons:

* Book Consultation
* Chat on WhatsApp
* Apply Now

---

2. ABOUT PAGE

---

Include:

* Company history
* Mission
* Vision
* Core values
* Certifications
* Why clients trust them
* Team section
* Office information

---

3. SERVICES PAGE

---

Split into categories:

A. Travel Services

* Flight ticketing
* Hotel reservation
* Airport pickup/shuttle
* Holiday packages
* Travel insurance
* Tour planning

B. Visa Services

* Tourist visa
* Student visa
* Business visa
* Work visa
* Visa consultation

C. Study Abroad

* UK admissions
* Canada admissions
* USA admissions
* Australia admissions
* Ireland admissions
* Scholarship guidance

D. Corporate/CAC Services

* Business registration
* NGO registration
* Company upgrade
* Annual returns
* SCUML
* TIN
* Tax clearance
* Change of directors

Each service should have:

* Dedicated detail page
* Hero image
* Benefits
* Requirements
* FAQ
* CTA form

---

4. DESTINATIONS PAGE

---

Feature:

* Countries
* Cities
* Travel packages
* Study destinations

Include:

* Country cards
* Requirements
* Cost estimate
* Inquiry button

Countries:

* UK
* USA
* Canada
* China
* UAE
* Australia
* Ireland

---

5. VISA INFORMATION PAGE

---

Include:

* Visa types
* Requirements
* Processing time
* FAQs
* Consultation form

Create reusable visa template pages.

---

6. STUDY ABROAD PAGE

---

Include:

* Countries available
* Admission process
* Requirements
* Tuition guidance
* Student visa guidance
* Inquiry form

---

7. CAC & BUSINESS SERVICES PAGE

---

Include:

* CAC registration
* NGO registration
* SCUML
* TIN
* Annual returns
* Tax clearance

Add:

* Pricing cards
* Processing duration
* Requirements
* FAQs

---

8. BLOG / NEWS SECTION

---

Build CMS-style blog system.

Admin can:

* Create posts
* Upload featured images
* Draft/publish posts
* Categorize posts
* Add tags

Frontend should support:

* SEO-friendly URLs
* Search
* Pagination
* Related posts

Suggested categories:

* Travel Tips
* Visa Updates
* Study Abroad
* CAC News
* Immigration News

---

9. TESTIMONIALS PAGE

---

Include:

* Customer reviews
* Photos
* Star ratings

Admin can manage testimonials.

---

10. GALLERY PAGE

---

Include:

* Travel photos
* Office photos
* Events
* Student success stories

Use ActiveStorage.

---

11. FAQ PAGE

---

Grouped FAQs by category.

---

12. CONTACT PAGE

---

Include:

* Contact form
* Office address
* Embedded map
* Phone numbers
* WhatsApp link
* Email address
* Business hours

==================================================
IMPORTANT BUSINESS FEATURES
===========================

---

## LEAD MANAGEMENT SYSTEM

Build inquiry system for:

* Travel inquiries
* Visa inquiries
* Admission inquiries
* CAC inquiries

Admin dashboard should support:

* View leads
* Assign statuses
* Add notes
* Contact tracking
* Lead filtering

Statuses:

* New
* Contacted
* Pending
* Converted
* Closed

---

## WHATSAPP INTEGRATION

Add floating WhatsApp button sitewide.

Every service page should have:

* WhatsApp CTA
* Prefilled WhatsApp messages

---

## NEWSLETTER SYSTEM

Collect emails.

Admin can export subscribers.

---

## SEARCH SYSTEM

Sitewide search for:

* Blog posts
* Services
* FAQs
* Destinations

---

## ADMIN DASHBOARD

Build custom admin panel.

Admin can manage:

* Services
* Pages
* Blog posts
* Testimonials
* Leads
* FAQs
* Gallery
* Team members
* Destinations
* SEO metadata
* Homepage sections

Dashboard should include:

* Inquiry statistics
* Visitor overview
* Recent leads
* Recent posts

---

## ROLE-BASED ACCESS

Roles:

* Super Admin
* Staff
* Content Editor

Permissions using Pundit.

==================================================
FUTURE FEATURES (IMPORTANT)
===========================

Architect database and system to support future expansion.

Future modules include:

---

1. CLIENT PORTAL

---

Clients can:

* Track visa applications
* Upload documents
* Receive updates
* Chat with staff
* Download invoices

---

2. ONLINE PAYMENTS

---

Integrate:

* Paystack
* Flutterwave
* Stripe

Allow payment for:

* Visa processing
* Consultation
* Flight booking deposits
* CAC services

---

3. DOCUMENT MANAGEMENT SYSTEM

---

Clients upload:

* Passport
* Admission documents
* Certificates
* CAC documents

Staff can review and approve.

---

4. APPOINTMENT BOOKING SYSTEM

---

Clients can:

* Schedule consultations
* Choose available dates
* Receive reminders

---

5. LIVE CHAT SYSTEM

---

Real-time chat support using:

* Turbo Streams
* ActionCable

---

6. MULTI-BRANCH SUPPORT

---

Support multiple office locations in future.

---

7. CRM MODULE

---

Advanced customer management.

---

8. EMAIL & SMS NOTIFICATIONS

---

Notifications for:

* Application updates
* Reminders
* Payments
* Appointments

---

9. AI ASSISTANT

---

Future AI chatbot for:

* Visa guidance
* FAQ responses
* Inquiry routing

---

10. MULTI-LANGUAGE SUPPORT

---

Prepare architecture for localization.

==================================================
SEO REQUIREMENTS
================

Implement:

* Meta titles
* Meta descriptions
* OpenGraph tags
* Structured schema
* XML sitemap
* robots.txt
* Canonical URLs
* Fast page loading
* Semantic HTML

Optimize for keywords like:

* Travel agency in Warri
* Visa assistance Nigeria
* Canada admission consultant
* CAC registration Warri
* Study abroad Nigeria

==================================================
PERFORMANCE & SECURITY
======================

Implement:

* Rate limiting
* Secure authentication
* CSRF protection
* Input sanitization
* Image optimization
* Lazy loading
* Database indexing
* Query optimization
* Responsive image handling

==================================================
DEPLOYMENT REQUIREMENTS
=======================

Prepare production-ready deployment using:

* Docker
* Kamal
* Ubuntu VPS
* Nginx reverse proxy
* SSL via Let's Encrypt

Deployment target:

* Hetzner
* Contabo
* Hostinger VPS

==================================================
DELIVERABLES REQUIRED
=====================

Generate:

1. Complete Rails application
2. Database schema
3. Models
4. Controllers
5. Routes
6. ERB views
7. Tailwind styling
8. Stimulus controllers
9. Admin dashboard
10. Authentication system
11. SEO setup
12. Docker setup
13. Kamal deployment config
14. Seed data
15. README documentation
16. Environment variable documentation
17. Production deployment guide

==================================================
IMPORTANT DEVELOPMENT RULES
===========================

* Keep code modular and scalable
* Use Rails conventions
* Avoid unnecessary gems
* Prefer Rails-native solutions
* Use service objects where appropriate
* Use partials/components for reusable UI
* Keep UI elegant and lightweight
* Ensure accessibility compliance
* Ensure mobile-first responsiveness
* Maintain clean folder architecture

==================================================
FINAL OBJECTIVE
===============

Build a modern, scalable digital platform that positions NEWPAGE INTEGRITY TRAVELS & TOURS LIMITED as a premium and trustworthy travel, immigration, education, and corporate services brand in Nigeria and internationally.

The final product should look like a professional international consulting/travel company website — not a generic template website.
