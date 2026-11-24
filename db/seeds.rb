puts "=== Seeding NewPage Integrity Travels & Tours ==="

# 1. Super Admin User
admin = User.find_or_create_by!(email: "admin@newpageintegrity.com") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
  u.first_name = "Super"
  u.last_name = "Admin"
  u.role = :super_admin
end

# 2. CMS Page Settings (all site pages + global settings)
cms_pages = [
  {
    key: "global",
    page_name: "Global Site Settings",
    hero_title: "NewPage Integrity Travels & Tours Limited",
    meta_title: "NewPage Integrity Travels & Tours | Travel, Visa, Study Abroad & CAC in Nigeria",
    meta_description: "Premier travel agency in Warri, Delta State offering flight ticketing, visa assistance, study abroad admissions, and CAC business registration.",
    settings: {
      "address" => "No 4 Airport Road, Opposite Kosini Junction, Warri, Delta State, Nigeria",
      "phone" => "+234 803 865 6409",
      "whatsapp_number" => "2348038656409",
      "email" => "newpageintegritytravels@gmail.com",
      "business_hours" => "Mon - Fri: 8:30 AM - 5:30 PM | Sat: 10:00 AM - 3:00 PM",
      "facebook_url" => "https://facebook.com",
      "instagram_url" => "https://instagram.com",
      "linkedin_url" => "https://linkedin.com"
    }
  },
  {
    key: "home",
    page_name: "Home Page",
    hero_title: "Your Gateway to Global Opportunities",
    hero_subtitle: "Expert travel & tours, visa assistance, international university admissions, and CAC corporate consulting — delivered with integrity.",
    meta_title: "Travel Agency in Warri | Visa Assistance, Study Abroad & CAC Registration",
    meta_description: "Book flights, process UK/USA/Canada/Schengen/UAE visas, secure overseas university admissions, and register your business with CAC in Nigeria.",
    settings: {
      "hero_badge" => "NEWPAGE INTEGRITY TRAVELS & TOURS LIMITED",
      "stat_years" => "10+",
      "stat_visas" => "5,000+",
      "stat_destinations" => "50+",
      "stat_satisfaction" => "99%"
    }
  },
  {
    key: "about",
    page_name: "About Us Page",
    hero_title: "About NewPage Integrity",
    hero_subtitle: "Your trusted partner in navigating global travel, international education, and corporate affairs with transparency and professionalism.",
    meta_title: "About Us | NewPage Integrity Travels & Tours"
  },
  {
    key: "visa_information",
    page_name: "Visa Information Page",
    hero_title: "Expert Visa & Immigration Assistance",
    hero_subtitle: "Seamless tourist, student, work, and business visa consulting for the UK, USA, Canada, Schengen Europe, UAE, South Africa, India & China.",
    meta_title: "Visa Assistance Nigeria | UK, USA, Canada, Schengen & UAE Visas"
  },
  {
    key: "study_abroad",
    page_name: "Study Abroad Page",
    hero_title: "Your Journey to a Global Degree",
    hero_subtitle: "Academic counseling, overseas university applications, scholarship guidance, and student visa processing.",
    meta_title: "Study Abroad Nigeria | UK, Canada, USA & Australia Admissions"
  },
  {
    key: "cac_services",
    page_name: "CAC & Corporate Services Page",
    hero_title: "CAC & Corporate Registrations",
    hero_subtitle: "Fast, compliant Business Name, Limited Liability Company, NGO, SCUML, TIN, and Annual Returns filing in Nigeria.",
    meta_title: "CAC Registration Warri & Nigeria | Business Name, LLC, NGO & SCUML"
  },
  { key: "services", page_name: "Services Directory", hero_title: "Our Professional Services", meta_title: "Our Services | Travel, Visas, Study Abroad & CAC" },
  { key: "destinations", page_name: "Destinations Directory", hero_title: "Explore Global Destinations", meta_title: "Top Travel & Study Destinations" },
  { key: "blog", page_name: "Blog & News Page", hero_title: "Travel, Visa & Study Insights", meta_title: "Travel Tips, Visa Updates & Study Abroad News" },
  { key: "gallery", page_name: "Photo Gallery Page", hero_title: "Our Photo Gallery", meta_title: "Photo Gallery | Client Success & Tours" },
  { key: "testimonials", page_name: "Testimonials Page", hero_title: "What Our Clients Say", meta_title: "Client Testimonials & Reviews" },
  { key: "faq", page_name: "FAQ Page", hero_title: "Frequently Asked Questions", meta_title: "FAQs | Visas, Study Abroad & CAC" },
  { key: "contact", page_name: "Contact Page", hero_title: "Contact NewPage Integrity", meta_title: "Contact Us | Warri Office & Consultation Booking" },
  { key: "privacy_policy", page_name: "Privacy Policy", hero_title: "Privacy Policy", meta_title: "Privacy Policy" },
  { key: "terms_of_service", page_name: "Terms of Service", hero_title: "Terms of Service", meta_title: "Terms of Service" }
]

cms_pages.each do |attrs|
  PageSetting.find_or_create_by!(key: attrs[:key]) do |ps|
    ps.page_name = attrs[:page_name]
    ps.hero_title = attrs[:hero_title]
    ps.hero_subtitle = attrs[:hero_subtitle]
    ps.meta_title = attrs[:meta_title]
    ps.meta_description = attrs[:meta_description]
    ps.settings = attrs[:settings] || {}
  end
end

# 3. Blog Categories
categories = {}
["Travel Tips", "Visa Updates", "Study Abroad", "Business & CAC", "Immigration News"].each do |name|
  categories[name] = BlogCategory.find_or_create_by!(name: name)
end

# 4. Services across all 4 categories
services_data = [
  {
    title: "Domestic & International Flight Ticketing",
    category: :travel,
    featured: true,
    position: 1,
    short_description: "Competitive fares, flexible itineraries, and 24/7 booking support for personal and corporate travel.",
    description: "We arrange domestic and international flights across major global airlines with transparent pricing, multi-city routing, and rapid rebooking support.",
    benefits: "Competitive Airline Fares\n24/7 Support & Itinerary Changes\nCorporate & Group Booking Discounts",
    requirements: "Valid International Passport Data Page\nPreferred Travel Dates & Route\nContact Phone & Email"
  },
  {
    title: "Hotel Reservations & Holiday Tour Packages",
    category: :travel,
    featured: true,
    position: 2,
    short_description: "Curated leisure getaways, family vacations, honeymoon packages, and verified hotel stays worldwide.",
    description: "From Dubai luxury escapes and Kigali city tours to European holidays and airport pickups, we design stress-free itineraries tailored to your budget.",
    benefits: "Verified 3-to-5 Star Hotels\nAirport Pickup & Guided Tours\nCustom Family & Honeymoon Packages",
    requirements: "Destination & Travel Dates\nNumber of Travelers\nPreferred Budget Range"
  },
  {
    title: "Tourist & Visit Visa Assistance",
    category: :visa,
    featured: true,
    position: 3,
    short_description: "Comprehensive visa advisory and filing for the UK, USA, Canada, Schengen, UAE, South Africa, and India.",
    description: "Our visa specialists guide you through documentation, form accuracy, financial presentation, appointment scheduling, and embassy interview preparation.",
    benefits: "Thorough Document Verification\nMock Embassy Interview Coaching\nHigh Approval Success Rate",
    requirements: "Valid Passport (6+ Months)\n6 Months Bank Statement\nEmployment / Business Proof\nTravel Itinerary"
  },
  {
    title: "Business & Work Visa Consulting",
    category: :visa,
    featured: false,
    position: 4,
    short_description: "Strategic immigration support for corporate executives, conference attendees, and skilled workers.",
    description: "We assist companies and professionals with invitation letters, sponsorship documentation, and compliant business/work visa applications.",
    benefits: "Corporate Documentation Review\nPriority Appointment Guidance\nDedicated Case Officer",
    requirements: "Company Introduction / Invitation Letter\nCAC & Tax Documents (if applicable)\nValid International Passport"
  },
  {
    title: "UK, Canada & USA University Admissions",
    category: :study_abroad,
    featured: true,
    position: 5,
    short_description: "End-to-end overseas admission processing, academic counseling, and scholarship guidance.",
    description: "We help undergraduate and postgraduate applicants select accredited universities, refine Statements of Purpose, secure offers, and process student visas.",
    benefits: "No-IELTS University Options Available\nScholarship & Tuition Guidance\nComplete Student Visa Support",
    requirements: "Academic Transcripts & Certificates\nWAEC / NECO or Degree Result\nInternational Passport\nCV & Statement of Purpose"
  },
  {
    title: "CAC Business Name & LLC Registration",
    category: :cac,
    featured: true,
    position: 6,
    short_description: "Fast, transparent registration of Business Names, Limited Liability Companies, and NGOs with CAC.",
    description: "Launch your business legally in Nigeria. We handle name availability, CAC incorporation, TIN generation, SCUML, and annual returns.",
    benefits: "Fast 7-14 Day Turnaround\nTIN & Status Report Included\nPost-Incorporation & Annual Returns Support",
    requirements: "2 Proposed Business Names\nValid Government ID (NIN/Passport/Driver's License)\nPassport Photograph & Signature"
  },
  {
    title: "NGO, SCUML & Annual Returns Filing",
    category: :cac,
    featured: false,
    position: 7,
    short_description: "Complete Incorporated Trustees registration, EFCC SCUML certification, and annual CAC compliance.",
    description: "Stay compliant and unlock corporate banking and grants with our specialized NGO registration, SCUML, and annual returns service.",
    benefits: "Full Newspaper Publication Handling\nEFCC SCUML Documentation\nPenalty-Free Annual Filing",
    requirements: "Trustees Details & Valid IDs\nConstitution & Minutes of Meeting\nCAC Registration Number (for SCUML/Returns)"
  }
]

services_data.each do |attrs|
  Service.find_or_create_by!(title: attrs[:title]) do |s|
    s.category = attrs[:category]
    s.featured = attrs[:featured]
    s.position = attrs[:position]
    s.short_description = attrs[:short_description]
    s.description = attrs[:description]
    s.benefits = attrs[:benefits]
    s.requirements = attrs[:requirements]
    s.published = true
  end
end

# 5. Destinations (Travel & Study)
destinations_data = [
  { name: "United Kingdom", country_code: "GB", category: :study, featured: true, position: 1, cost_estimate: "£12,000 / year", short_description: "World-renowned universities, 2-year Graduate Route post-study work visa, and rich cultural heritage.", requirements: "Valid International Passport\nCAS Letter from UK University\nProof of Funds (28-day rule)\nTB Test Certificate" },
  { name: "Canada", country_code: "CA", category: :study, featured: true, position: 2, cost_estimate: "$15,000 CAD / year", short_description: "Top destination for international education, post-graduation work permits, and permanent residency pathways.", requirements: "Letter of Acceptance (LOA) & PAL\nProof of Financial Support\nValid Passport & Biometrics\nStatement of Purpose" },
  { name: "United States", country_code: "US", category: :study, featured: true, position: 3, cost_estimate: "$18,000 USD / year", short_description: "Global leader in technology, business, and research universities plus iconic tourist destinations.", requirements: "Form I-20 (Students) or DS-160\nSEVIS Fee Receipt (F-1)\nFinancial Sponsor Documentation\nEmbassy Interview" },
  { name: "United Arab Emirates", country_code: "AE", category: :travel, featured: true, position: 4, cost_estimate: "$1,450 Package", short_description: "Luxury Dubai getaways, desert safaris, shopping festivals, and fast UAE tourist visa processing.", requirements: "Passport Data Page (6+ months validity)\nPassport Photograph\nReturn Flight & Hotel Booking" },
  { name: "Australia", country_code: "AU", category: :study, featured: false, position: 5, cost_estimate: "$20,000 AUD / year", short_description: "High-ranking universities, vibrant coastal cities, and generous post-study work opportunities.", requirements: "Confirmation of Enrolment (CoE)\nOSHC Health Cover\nGenuine Student Statement\nProof of Funds" },
  { name: "Ireland", country_code: "IE", category: :study, featured: false, position: 6, cost_estimate: "€11,500 / year", short_description: "English-speaking European tech hub with affordable tuition and strong graduate employment.", requirements: "University Offer Letter\nProof of Tuition Payment\nMedical Insurance\nFinancial Documentation" },
  { name: "China", country_code: "CN", category: :travel, featured: false, position: 7, cost_estimate: "$1,900 Business Trip", short_description: "Trade fairs (Canton Fair), business procurement tours, and study opportunities across China.", requirements: "Valid Passport\nBusiness Invitation Letter (M Visa)\nFlight & Hotel Confirmation" }
]

destinations_data.each do |attrs|
  Destination.find_or_create_by!(name: attrs[:name]) do |d|
    d.country_code = attrs[:country_code]
    d.category = attrs[:category]
    d.featured = attrs[:featured]
    d.position = attrs[:position]
    d.cost_estimate = attrs[:cost_estimate]
    d.short_description = attrs[:short_description]
    d.description = attrs[:short_description]
    d.requirements = attrs[:requirements]
    d.visa_required = true
    d.published = true
  end
end

# 6. Testimonials
[
  { client_name: "Adeola Balogun", service_type: :study, rating: 5, content: "NewPage Integrity Travels made my UK study visa and university admission completely stress-free. Their attention to every document detail is unmatched!" },
  { client_name: "Emeka Okoro", service_type: :cac, rating: 5, content: "Got my CAC Limited Liability Company and TIN registered swiftly with zero hidden charges. Highly professional and transparent team in Warri." },
  { client_name: "Precious Efe", service_type: :visa, rating: 5, content: "Their mock interview coaching and document audit helped our family secure our Canada visitor visas on the very first attempt." }
].each_with_index do |attrs, idx|
  Testimonial.find_or_create_by!(client_name: attrs[:client_name]) do |t|
    t.service_type = attrs[:service_type]
    t.rating = attrs[:rating]
    t.content = attrs[:content]
    t.position = idx + 1
    t.published = true
  end
end

# 7. FAQs
[
  { question: "How long does a UK or Canada study visa application take?", answer: "Standard UK student visa decisions take approximately 3 weeks after biometrics (with 5-day priority options). Canada study permits typically take 6–12 weeks depending on season.", category: :visas },
  { question: "Can I study abroad in the UK or Canada without IELTS?", answer: "Yes. Many partner universities in the UK and Europe accept WAEC/NECO English (C6 and above) or a Medium of Instruction letter in place of IELTS.", category: :study_abroad },
  { question: "What do I need for CAC Business Name or Company Registration?", answer: "You need two proposed business names, a valid government-issued ID (NIN, International Passport, or Driver's License), passport photograph, signature specimen, and business address.", category: :cac },
  { question: "Do you handle flight bookings and airport pickups for travelers?", answer: "Yes, we book both domestic and international flights, hotel reservations, travel insurance, and airport transfers.", category: :travel }
].each_with_index do |attrs, idx|
  Faq.find_or_create_by!(question: attrs[:question]) do |f|
    f.answer = attrs[:answer]
    f.category = attrs[:category]
    f.position = idx + 1
    f.published = true
  end
end

# 8. Starter Blog Posts
[
  {
    title: "Complete Guide to Studying in the UK from Nigeria",
    category: "Study Abroad",
    excerpt: "Everything Nigerian students need to know about UK university admissions, WAEC English waivers, proof of funds, and student visa timelines.",
    tags: "uk study visa, study abroad nigeria, admissions",
    body: "Studying in the United Kingdom remains one of the smartest investments for Nigerian students seeking globally recognized degrees and the 2-year Graduate Route work visa. Start by shortlisting accredited universities, preparing your transcripts and Statement of Purpose, and ensuring your maintenance funds meet UKVI's 28-day rule."
  },
  {
    title: "5 Common Visa Mistakes That Cause Rejections — And How to Avoid Them",
    category: "Visa Updates",
    excerpt: "Avoid preventable visa refusals by mastering financial documentation, strong home ties, and consistent application forms.",
    tags: "visa tips, embassy interview, travel agency warri",
    body: "Most tourist and student visa refusals stem from avoidable documentation errors: unexplained lump-sum deposits in bank statements, inconsistent travel histories, or poorly articulated travel purposes. Working with an experienced visa consultant ensures your application tells a clear, verifiable story."
  },
  {
    title: "Why Registering Your Business with CAC Unlocks Corporate Growth",
    category: "Business & CAC",
    excerpt: "From corporate bank accounts to embassy credibility and SME grants, here is why formalizing your Nigerian business pays off immediately.",
    tags: "cac registration warri, business name, scuml",
    body: "Whether you run a growing venture in Warri or an international consulting brand, CAC registration gives your business legal standing, corporate banking access, and stronger credibility with clients, investors, and embassies."
  }
].each do |attrs|
  BlogPost.find_or_create_by!(title: attrs[:title]) do |bp|
    bp.blog_category = categories[attrs[:category]]
    bp.author = admin
    bp.excerpt = attrs[:excerpt]
    bp.tags = attrs[:tags]
    bp.body = attrs[:body]
    bp.status = :published
    bp.published_at = Time.current
    bp.featured = true
  end
end

# 9. Starter Team Member
TeamMember.find_or_create_by!(name: "NewPage Advisory Team") do |tm|
  tm.role = "Travel, Visa & Corporate Consultants"
  tm.bio = "Dedicated specialists guiding clients through international travel bookings, visa documentation, overseas admissions, and CAC corporate filings."
  tm.email = "newpageintegritytravels@gmail.com"
  tm.phone = "+234 803 865 6409"
  tm.position = 1
  tm.published = true
end

puts "=== Seed Complete! ==="
