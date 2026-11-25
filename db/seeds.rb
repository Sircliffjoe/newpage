puts "=== Seeding NewPage Integrity Travels & Tours ==="

SEED_ASSETS_DIR = Rails.root.join("db", "seed_assets")

def attach_seed_image(record, attachment_name, filename)
  path = SEED_ASSETS_DIR.join(filename)
  return unless File.exist?(path)

  attachment = record.public_send(attachment_name)
  return if attachment.attached? && attachment.blob.filename.to_s == filename

  attachment.attach(
    io: File.open(path),
    filename: filename,
    content_type: "image/jpeg"
  )
end

def attach_seed_flyers(record, filenames)
  existing_names = record.flyers.map { |f| f.filename.to_s }
  filenames.each do |filename|
    next if existing_names.include?(filename)

    path = SEED_ASSETS_DIR.join(filename)
    next unless File.exist?(path)

    record.flyers.attach(
      io: File.open(path),
      filename: filename,
      content_type: "image/jpeg"
    )
  end
end

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
    meta_description: "Award-winning travel agency in Warri, Delta State offering flight ticketing, visa assistance, study abroad admissions, and CAC business registration.",
    settings: {
      "address" => "Top Floor, No. 4 Airport Road, Opposite Kosini Junction, Warri, Delta State, Nigeria",
      "phone" => "+234 803 865 6409",
      "secondary_phones" => "+234 908 289 8777, +234 803 626 9807",
      "whatsapp_number" => "2348038656409",
      "email" => "newpageintegritytravels@gmail.com",
      "website" => "https://www.newpageintegritytravels.com",
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
    hero_subtitle: "NANTA Award-winning travel & tours, visa & residency consulting, international university admissions, and CAC corporate registration — delivered with integrity.",
    meta_title: "Travel Agency in Warri | Visa Assistance, Study Abroad & CAC Registration",
    meta_description: "Book flights on all airlines worldwide, process UK/USA/Canada/Schengen/Oman/Qatar visas, secure 2027 overseas university admissions, and register your business with CAC.",
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
    hero_subtitle: "Led by Founder & CEO Mrs. Ify Adegoke, we are your trusted partner in global travel, international education, and corporate affairs.",
    meta_title: "About Us | NewPage Integrity Travels & Tours"
  },
  {
    key: "visa_information",
    page_name: "Visa Information Page",
    hero_title: "Expert Visa & Immigration Assistance",
    hero_subtitle: "Seamless tourist, student, work, business, and residency visa consulting for the UK, USA, Canada, Schengen Europe, UAE, Oman, Qatar, South Africa, India & China.",
    meta_title: "Visa Assistance Nigeria | UK, USA, Canada, Oman, Qatar & Schengen Visas"
  },
  {
    key: "study_abroad",
    page_name: "Study Abroad Page",
    hero_title: "Your Journey to a Global Degree",
    hero_subtitle: "2027 Admissions Open — Canada, UK, USA, Australia, Ireland, France, Malaysia, Germany, Spain & Dubai, plus online professional certifications.",
    meta_title: "Study Abroad Nigeria | Canada, UK, Ireland, France & Malaysia Admissions"
  },
  {
    key: "cac_services",
    page_name: "CAC & Corporate Services Page",
    hero_title: "CAC & Corporate Registrations",
    hero_subtitle: "Fast, compliant Business Name, Limited Liability (LTD), Church & NGO, Association, Company Upgrade, Change of Director, Share Increase, TIN, Tax Clearance, SCUML & Annual Returns.",
    meta_title: "CAC Registration Warri & Nigeria | Business Name, LLC, NGO & SCUML"
  },
  { key: "services", page_name: "Services Directory", hero_title: "Our Professional Services", meta_title: "Our Services | Travel, Visas, Study Abroad & CAC" },
  { key: "destinations", page_name: "Destinations Directory", hero_title: "Explore Global Destinations", meta_title: "Top Travel & Study Destinations" },
  { key: "awards", page_name: "Awards & Recognition Page", hero_title: "Awards & Recognition", hero_subtitle: "Industry honours and leadership recognitions earned by NewPage Integrity Travels & Tours Limited and Founder/CEO Mrs. Ify Adegoke.", meta_title: "Awards & Recognition | NewPage Integrity Travels & Tours" },
  { key: "blog", page_name: "Blog & News Page", hero_title: "Travel, Visa & Health Insights", meta_title: "Travel Tips, Visa Updates, Study Abroad News & Health Alerts" },
  { key: "gallery", page_name: "Photo Gallery Page", hero_title: "Our Photo Gallery", hero_subtitle: "Highlights from NANTA Eastern Zone AGM & Awards Night, community outreach, partner campaigns, and client milestones.", meta_title: "Photo Gallery | NewPage Integrity Travels & Tours" },
  { key: "testimonials", page_name: "Testimonials Page", hero_title: "What Our Clients Say", meta_title: "Client Testimonials & Reviews" },
  { key: "faq", page_name: "FAQ Page", hero_title: "Frequently Asked Questions", meta_title: "FAQs | Visas, Study Abroad & CAC" },
  { key: "contact", page_name: "Contact Page", hero_title: "Contact NewPage Integrity", meta_title: "Contact Us | Warri Office & Consultation Booking" },
  { key: "privacy_policy", page_name: "Privacy Policy", hero_title: "Privacy Policy", meta_title: "Privacy Policy" },
  { key: "terms_of_service", page_name: "Terms of Service", hero_title: "Terms of Service", meta_title: "Terms of Service" }
]

cms_pages.each do |attrs|
  ps = PageSetting.find_or_initialize_by(key: attrs[:key])
  ps.page_name = attrs[:page_name]
  ps.hero_title = attrs[:hero_title]
  ps.hero_subtitle = attrs[:hero_subtitle] if attrs[:hero_subtitle].present?
  ps.meta_title = attrs[:meta_title]
  ps.meta_description = attrs[:meta_description] if attrs[:meta_description].present?
  ps.settings = (ps.settings || {}).merge(attrs[:settings] || {})
  ps.save!
end

# 3. Blog Categories
categories = {}
[ "Travel Tips", "Visa Updates", "Study Abroad", "Business & CAC", "Immigration News", "Travel Health & Safety" ].each do |name|
  categories[name] = BlogCategory.find_or_create_by!(name: name)
end

# 4. Services (Updated existing + newly created from /files & content.md)
services_data = [
  {
    title: "Domestic & International Flight Ticketing",
    category: :travel,
    featured: true,
    position: 1,
    hero_asset: "flights-international.jpg",
    flyer_assets: [ "flights-domestic-nigeria.jpg" ],
    short_description: "Best deals on domestic flights to all states in Nigeria and international flights across all major airlines worldwide.",
    description: "We are accredited travel agents to all airlines worldwide. Whether you are flying domestically across Nigeria (Ibom Air, Air Peace, Azman Air, MaxAir, Arik Air, Dana Air, Aero) or internationally (British Airways, Emirates, Air France, Qatar Airways, United, EgyptAir, Delta, Turkish Airlines, Lufthansa, Virgin Atlantic, KLM, Ethiopian Airlines), we secure competitive fares, flexible itineraries, and 24/7 booking support.",
    benefits: "Best Deals Across All Domestic & Global Airlines\n24/7 Support, Rebooking & Itinerary Changes\nCorporate, Family & Group Booking Discounts\nVerified NANTA Accredited Travel Advisors",
    requirements: "Valid International Passport Data Page (International) or Valid ID (Domestic)\nPreferred Travel Dates & Route\nContact Phone / WhatsApp & Email"
  },
  {
    title: "Hotel Reservations & Holiday Tour Packages",
    category: :travel,
    featured: true,
    position: 2,
    hero_asset: "brand-study-travel-explore.jpg",
    flyer_assets: [],
    short_description: "Local and international hotel reservations, curated family vacations, honeymoon getaways, and guided holiday tours.",
    description: "Enjoy seamless local and international hotel reservations paired with memorable holiday tour packages. From Dubai luxury escapes and East African tours to European holidays and Nigerian resort stays, we tailor every itinerary to your comfort and budget.",
    benefits: "Verified 3-to-5 Star Local & International Hotels\nCurated Family, Group & Honeymoon Packages\nSeamless Flight + Hotel + Tour Bundles",
    requirements: "Destination & Check-in / Check-out Dates\nNumber of Guests & Room Preferences\nPreferred Budget Range"
  },
  {
    title: "International Passport Processing & Renewal",
    category: :travel,
    featured: false,
    position: 3,
    hero_asset: "company-travel-flyer.jpg",
    flyer_assets: [],
    short_description: "Guided assistance for fresh Nigerian international passport applications, renewals, and data corrections.",
    description: "Avoid delays and avoidable documentation errors when applying for or renewing your Nigerian international passport. Our team guides you through online registration, document verification, appointment scheduling, and smooth processing.",
    benefits: "Step-by-Step Application & Form Guidance\nDocument & NIN Alignment Verification\nFresh Application & Renewal Support",
    requirements: "National Identification Number (NIN)\nBirth Certificate / Age Declaration\nLocal Government Certificate of Origin\nExisting Passport (for Renewals)"
  },
  {
    title: "Local & International Airport Shuttles",
    category: :travel,
    featured: false,
    position: 4,
    hero_asset: "company-travel-flyer.jpg",
    flyer_assets: [],
    short_description: "Safe, punctual local and international airport pickups, drop-offs, and executive chauffeur transfers.",
    description: "Arrive and depart with peace of mind. We arrange reliable local and international airport shuttle transfers for business travelers, families, and arriving international students, ensuring seamless connections from terminal to hotel or campus.",
    benefits: "Punctual Meet-and-Greet Airport Pickups\nVetted Vehicles for Solo, Family & Group Travel\nDomestic & International Arrival Coverage",
    requirements: "Confirmed Flight Itinerary & Arrival Time\nPickup / Drop-off Address\nNumber of Passengers & Luggage Details"
  },
  {
    title: "Travel Health Insurance",
    category: :travel,
    featured: false,
    position: 5,
    hero_asset: "company-travel-flyer.jpg",
    flyer_assets: [],
    short_description: "Embassy-compliant travel medical insurance for Schengen, UK, USA, Canada, student, and leisure travelers.",
    description: "Protect yourself against unexpected medical emergencies, trip cancellations, and lost baggage abroad. We issue fast, embassy-recognized travel health insurance certificates required for Schengen visas, study abroad applications, and international vacations.",
    benefits: "Embassy & Schengen-Compliant Medical Coverage\nInstant Policy Issuance & Certificate Delivery\nPlans for Tourists, Students & Business Travelers",
    requirements: "International Passport Data Page\nDestination Country & Travel Dates\nNext-of-Kin Contact Information"
  },
  {
    title: "Travel Consultancy",
    category: :travel,
    featured: false,
    position: 6,
    hero_asset: "company-travel-flyer.jpg",
    flyer_assets: [ "brand-study-travel-explore.jpg" ],
    short_description: "Personalized travel planning, route optimization, corporate travel management, and end-to-end advisory.",
    description: "As an award-winning NANTA Eastern Zone Travel Agency of the Year, NewPage Integrity Travels & Tours Limited provides trusted travel consultancy for individuals, families, churches, and corporate organizations. Call or WhatsApp +234 803 865 6409, +234 908 289 8777, or +234 803 626 9807.",
    benefits: "Dedicated Personal Travel Advisor\nEnd-to-End Corporate & Group Travel Planning\nNANTA-Verified Trust, Reliability & Transparent Pricing",
    requirements: "Travel Purpose & Destination Goals\nPreferred Dates & Traveler Count\nContact Details for Consultation"
  },
  {
    title: "Tourist & Visit Visa Assistance",
    category: :visa,
    featured: true,
    position: 7,
    hero_asset: "brand-study-travel-explore.jpg",
    flyer_assets: [],
    short_description: "Comprehensive visa advisory and filing for the UK, USA, Canada, Schengen, UAE, Uganda, South Africa, and India.",
    description: "Our visa specialists guide you through documentation, form accuracy, financial presentation, appointment scheduling, and embassy interview preparation so your tourist or family visit application stands the strongest chance of approval.",
    benefits: "Thorough Document Verification & Audit\nMock Embassy Interview Coaching\nHigh Approval Success Rate",
    requirements: "Valid Passport (6+ Months)\n6 Months Bank Statement\nEmployment / Business Proof\nTravel Itinerary & Hotel Booking"
  },
  {
    title: "Business, Work & Gulf Residency Visas (Oman & Qatar)",
    category: :visa,
    featured: true,
    position: 8,
    hero_asset: "oman-residence-2yr.jpg",
    flyer_assets: [],
    short_description: "2-Year Oman Residence/Work Visa, Qatar Residence permits, and corporate business/work visa consulting.",
    description: "Relocate, work, or grow your career in the Gulf and beyond. We process Oman 2-Year Residence/Work Visas (offering stable job pathways and family sponsorship eligibility), Qatar Residence Permits, and global corporate/conference business visas with clear timelines and dedicated case officers.",
    benefits: "2-Year Oman Residence/Work Visa Processing\nFamily Sponsorship & Career Pathway Guidance\nQatar Residence & Corporate Business Visa Support\nDedicated Case Officer from Filing to Approval",
    requirements: "Valid International Passport (6+ Months)\nRecent Passport Photograph\nCV / Company Introduction or Invitation Letter (where applicable)"
  },
  {
    title: "Canada College & University Admissions (2027 Intakes)",
    category: :study_abroad,
    featured: true,
    position: 9,
    hero_asset: "study-canada-stclair-spring2027.jpg",
    flyer_assets: [
      "study-canada-stclair-live.jpg",
      "study-canada-stclair-psw.jpg",
      "study-canada-stclair-cybersecurity.jpg",
      "study-canada-algoma.jpg",
      "study-canada-northwestern-hca.jpg"
    ],
    short_description: "2027 Intakes open at St. Clair College, Algoma University & Northwestern Polytechnic with fee waivers, PGWP & PR pathways.",
    description: "Applications are open for January, May, and September 2027 Canadian intakes! Highlighted partner institutions include: (1) St. Clair College, Windsor — 100% application fee waiver (save $125), priority offer letters (2–5 days), 6 months complimentary hostel accommodation, free transportation & health insurance, paid internships, Personal Support Worker (H932, 1-yr certificate, min 50% in 12th, Maths not required), and Cybersecurity & Automobility (T891, 2-yr Graduate Certificate, 3-yr PGWP-aligned, $3,000 CAD deposit to receive PAL). Deadlines: Jan 2027 (30 Nov 2026), May 2027 (15 April 2027), Sept 2027 open. (2) Algoma University (Brampton & Sault Ste. Marie) — $4,500 CAD deposit, 98.7% employability, 3-yr PGWP, PR pathways at Sault Ste. Marie, English test exemption for Nigerian students. (3) Northwestern Polytechnic (Alberta) — Alberta Health Care Aide Certificate (1-yr, Fall 2027, work-integrated learning).",
    benefits: "100% Application Fee Waiver at St. Clair College (Save $125)\n6 Months Complimentary Hostel, Transport & Health Insurance (St. Clair)\nUp to 3-Year PGWP-Eligible & PR-Aligned Programmes\nEnglish Language Test Exemption for Nigerian Students (Algoma)\nFast 2–5 Day Offer Turnaround & Low CAD Deposits",
    requirements: "WAEC / NECO or University Transcripts & Certificates\nValid International Passport\nEnglish Proficiency Evidence or Applicable Exemption\nProgram-Specific Documents (where required)"
  },
  {
    title: "UK University Admissions & Nursing Scholarships",
    category: :study_abroad,
    featured: true,
    position: 10,
    hero_asset: "study-uk-southampton-nursing.jpg",
    flyer_assets: [],
    short_description: "UK undergraduate & postgraduate admissions featuring University of Southampton £5,000/yr Automatic Adult Nursing Scholarships (2027 Entry).",
    description: "Secure admission to top UK universities with scholarship guidance and full student visa support. Featured 2027 Opportunity: The University of Southampton has confirmed the return of its Global Talent in Adult Nursing Scholarship for 2027 entry — offering £5,000 per year of study (BSc Adult Nursing up to 3 years; MSc Adult Nursing up to 2 years). This is an automatic award for eligible new self-funded international students with no separate scholarship application required. Contact NewPage Integrity Travels & Tours Limited on 08038656409 to apply.",
    benefits: "£5,000/Year Automatic Adult Nursing Scholarship (University of Southampton 2027)\nNo Separate Scholarship Application Required\nWAEC/NECO English Waiver Options at Partner UK Universities\nComplete CAS, Proof-of-Funds & UK Student Visa Processing",
    requirements: "Academic Transcripts & Degree / WAEC Certificates\nValid International Passport\nPersonal Statement / SOP & Reference Letters\nCV (for Postgraduate Applicants)"
  },
  {
    title: "Ireland & European University Admissions (Ireland, France, Germany & Spain)",
    category: :study_abroad,
    featured: false,
    position: 11,
    hero_asset: "study-ireland-jan-intake.jpg",
    flyer_assets: [ "study-france-live.jpg" ],
    short_description: "January Intake partner schools in Ireland (DBS, IBAT, ATU, Maynooth) plus newly launched France, Germany & Spain study pathways.",
    description: "Explore world-class European education across 10+ study destinations! In Ireland, start in the January Intake with top partner institutions including Dublin Business School (DBS), IBAT College Dublin, Atlantic Technological University (ATU), Dublin International Study Centre, and Maynooth University. Plus, France is now LIVE alongside Germany and Spain — giving you broader academic and post-study career opportunities across Europe.",
    benefits: "Top Irish Partner Schools Open for January Intake (Less Competition & Faster Decisions)\nFrance Now Live — 10+ Global Study Destinations\nAffordable European Tuition & Career-Ready Programmes\nFull Admission & European Student Visa Support",
    requirements: "Academic Transcripts & Certificates\nValid International Passport\nEnglish Proficiency / MOI (where applicable)\nStatement of Purpose & Financial Documentation"
  },
  {
    title: "Study in Malaysia & UK Degree Pathway (LSBF Malaysia)",
    category: :study_abroad,
    featured: false,
    position: 12,
    hero_asset: "study-malaysia-lsbf-uk.jpg",
    flyer_assets: [ "study-malaysia-faqs.jpg" ],
    short_description: "Start in Malaysia and finish in the UK at LSBF Malaysia, or study affordably in English across top Malaysian universities.",
    description: "Discover one of the world's most affordable, English-taught international study hubs! Through London School of Business & Finance (LSBF) Malaysia, students can start in Kuala Lumpur (Diploma or BSc, 2,000 MYR deposit, intakes in Jan/Feb, May/June, Oct/Nov, up to 26-year age gap accepted) and seamlessly transfer to finish at the London UK campus — earning the same accredited UK degree. Across Malaysia, annual tuition typically ranges from RM20,000–RM60,000+ with monthly living costs of RM1,500–RM2,500, and Nigerian WAEC, NECO, and HND holders are welcome.",
    benefits: "Start in Malaysia, Finish at UK Campus (Same Accredited UK Degree)\nAffordable Tuition & Living Costs (RM1,500–RM2,500/Month)\nNigerian WAEC, NECO & HND Qualifications Accepted\nMultiple Intakes Yearly (Jan/Feb, May/June, Oct/Nov)",
    requirements: "Valid International Passport & Passport Photographs\nWAEC / NECO / HND or University Transcripts\nEnglish Proficiency Evidence (where required)\nOffer Letter, Medical & Student Pass Documents"
  },
  {
    title: "Online Professional Certifications",
    category: :study_abroad,
    featured: false,
    position: 13,
    hero_asset: "brand-study-travel-explore.jpg",
    flyer_assets: [],
    short_description: "Internationally recognized online certifications across diverse professional fields for individuals and corporate clients.",
    description: "Upgrade your credentials from anywhere in the world. NewPage Integrity Travels & Tours Limited facilitates enrollment into accredited online certification programmes across healthcare, IT, business management, leadership, and technical fields — ideal for career advancement, corporate upskilling, and strengthening international study or immigration profiles.",
    benefits: "Flexible 100% Online Learning Across Multiple Fields\nGlobally Recognized Certificates for Career Growth\nIndividual & Corporate / Agency Client Enrollment",
    requirements: "Valid Government ID\nActive Email & Phone / WhatsApp\nSelected Field of Certification"
  },
  {
    title: "CAC Business Name & Company (LTD) Registration",
    category: :cac,
    featured: true,
    position: 14,
    hero_asset: "cac-services-flyer.jpg",
    flyer_assets: [],
    short_description: "Give your business a legal status: Business Name, Limited Liability (LTD), Company Upgrade, Change of Director & Share Increase.",
    description: "Launch and scale your business legally in Nigeria through NewPage Integrity Concerns. We handle name availability, Business Name registration, Limited Liability Company (LTD) incorporation, Company Upgrades, Change of Director, Share Increase / Allotment, and post-incorporation CAC filings with fast, reliable turnaround.",
    benefits: "Fast, Reliable & Transparent CAC Incorporation\nBusiness Name, LTD, Company Upgrade & Change of Director\nShare Increase / Allotment & Post-Incorporation Support\nStatus Report & Certificate Delivered Seamlessly",
    requirements: "2 Proposed Business / Company Names\nValid Government ID (NIN / Passport / Driver's License)\nPassport Photograph & Signature Specimen\nBusiness / Residential Address & Directors' Details"
  },
  {
    title: "NGO, Church, Annual Returns, TIN, Tax Clearance & SCUML",
    category: :cac,
    featured: false,
    position: 15,
    hero_asset: "cac-services-flyer.jpg",
    flyer_assets: [],
    short_description: "Church, NGO & Association registration, Annual Returns subscription, Personal & Company TIN, Tax Clearance Certificate & SCUML.",
    description: "Keep your organization compliant and unlock corporate banking, grants, and government contracts. We handle Incorporated Trustees (Church, NGO & Association) registration, Annual Returns filing and subscription reminders, Personal & Company TIN generation, Tax Clearance Certificates (TCC), and EFCC SCUML certification.",
    benefits: "Complete Church, NGO & Association Registration\nPenalty-Free Annual Returns Filing & Subscription\nPersonal & Company TIN + Tax Clearance Certificate\nEFCC SCUML Documentation & Processing",
    requirements: "Trustees Details & Valid IDs (for NGO/Church/Association)\nConstitution & Minutes of Meeting (for NGO)\nCAC Registration Number & Status Report (for Annual Returns / SCUML / Tax Clearance)"
  }
]

# Remove superseded legacy starter service records to prevent duplicates
superseded_service_titles = [
  "Global Flight Ticketing",
  "UK Study Visa Assistance",
  "Business Name Registration",
  "Business & Work Visa Consulting",
  "UK, Canada & USA University Admissions",
  "CAC Business Name & LLC Registration",
  "NGO, SCUML & Annual Returns Filing"
]
Service.where(title: superseded_service_titles).destroy_all

services_data.each do |attrs|
  service = Service.find_or_initialize_by(title: attrs[:title])
  service.category = attrs[:category]
  service.featured = attrs[:featured]
  service.position = attrs[:position]
  service.short_description = attrs[:short_description]
  service.description = attrs[:description]
  service.benefits = attrs[:benefits]
  service.requirements = attrs[:requirements]
  service.published = true
  service.save!

  attach_seed_image(service, :hero_image, attrs[:hero_asset]) if attrs[:hero_asset].present?
  attach_seed_flyers(service, attrs[:flyer_assets]) if attrs[:flyer_assets].present?
end

# 5. Destinations (Travel & Study — including Malaysia, France, Oman, Germany, Spain)
destinations_data = [
  {
    name: "Canada", country_code: "CA", category: :study, featured: true, position: 1,
    cost_estimate: "$3,000 CAD Deposit",
    hero_asset: "study-canada-stclair-spring2027.jpg",
    short_description: "2027 intakes open at St. Clair College, Algoma University & Northwestern Polytechnic with PGWP and PR pathways.",
    requirements: "WAEC / NECO or University Transcripts\nLetter of Acceptance (LOA) & PAL\nProof of Financial Support\nValid Passport & Biometrics"
  },
  {
    name: "United Kingdom", country_code: "GB", category: :study, featured: true, position: 2,
    cost_estimate: "£5,000/yr Scholarship",
    hero_asset: "study-uk-southampton-nursing.jpg",
    short_description: "World-renowned universities, 2-year Graduate Route visa, and University of Southampton 2027 £5,000/yr Adult Nursing Scholarships.",
    requirements: "Valid International Passport\nCAS Letter from UK University\nProof of Funds (28-day rule)\nTB Test Certificate"
  },
  {
    name: "Ireland", country_code: "IE", category: :study, featured: true, position: 3,
    cost_estimate: "€11,500 / year",
    hero_asset: "study-ireland-jan-intake.jpg",
    short_description: "January Intake partner schools open: DBS, IBAT College Dublin, ATU, Dublin ISC & Maynooth University.",
    requirements: "University Offer Letter\nProof of Tuition Payment\nMedical Insurance\nFinancial Documentation"
  },
  {
    name: "Malaysia", country_code: "MY", category: :study, featured: true, position: 4,
    cost_estimate: "RM20,000 / year",
    hero_asset: "study-malaysia-lsbf-uk.jpg",
    short_description: "Affordable English-taught degrees and LSBF Malaysia 'Start in Malaysia, Finish in the UK' global pathway.",
    requirements: "Valid International Passport\nWAEC / NECO / HND or Degree Transcripts\nOffer Letter & EMGS Student Pass Documents\nMedical Screening"
  },
  {
    name: "France", country_code: "FR", category: :study, featured: true, position: 5,
    cost_estimate: "€8,000 / year",
    hero_asset: "study-france-live.jpg",
    short_description: "France is now LIVE! World-class European universities, global exposure, and strong post-study career pathways.",
    requirements: "Valid International Passport\nAcademic Transcripts & Certificates\nCampus France / University Admission Letter\nProof of Financial Means"
  },
  {
    name: "Oman", country_code: "OM", category: :travel, featured: true, position: 6,
    cost_estimate: "2-Year Work Visa",
    hero_asset: "oman-residence-2yr.jpg",
    short_description: "Live and work in Oman with a 2-Year Residence/Work Visa, stable job opportunities, and family sponsorship pathways.",
    requirements: "Valid International Passport (6+ Months)\nPassport Photograph\nMedical & Police Clearance (where required)"
  },
  {
    name: "United States", country_code: "US", category: :study, featured: false, position: 7,
    cost_estimate: "$18,000 USD / year",
    short_description: "Global leader in technology, business, and research universities plus iconic tourist destinations.",
    requirements: "Form I-20 (Students) or DS-160\nSEVIS Fee Receipt (F-1)\nFinancial Sponsor Documentation\nEmbassy Interview"
  },
  {
    name: "United Arab Emirates", country_code: "AE", category: :travel, featured: false, position: 8,
    cost_estimate: "$1,450 Package",
    short_description: "Luxury Dubai getaways, study options, desert safaris, shopping festivals, and fast UAE visa processing.",
    requirements: "Passport Data Page (6+ months validity)\nPassport Photograph\nReturn Flight & Hotel Booking"
  },
  {
    name: "Australia", country_code: "AU", category: :study, featured: false, position: 9,
    cost_estimate: "$20,000 AUD / year",
    short_description: "High-ranking universities, vibrant coastal cities, and generous post-study work opportunities.",
    requirements: "Confirmation of Enrolment (CoE)\nOSHC Health Cover\nGenuine Student Statement\nProof of Funds"
  },
  {
    name: "Germany", country_code: "DE", category: :study, featured: false, position: 10,
    cost_estimate: "Low / Zero Tuition",
    short_description: "Europe's engineering and innovation powerhouse with English-taught degrees and affordable public universities.",
    requirements: "Academic Transcripts & Certificates\nUniversity Admission Letter\nBlocked Account (Sperrkonto)\nValid Passport & Health Insurance"
  },
  {
    name: "Spain", country_code: "ES", category: :study, featured: false, position: 11,
    cost_estimate: "€6,500 / year",
    short_description: "Vibrant European study destination offering accredited English-taught business, hospitality, and tech degrees.",
    requirements: "University Acceptance Letter\nValid International Passport\nProof of Financial Means & Medical Insurance"
  },
  {
    name: "China", country_code: "CN", category: :travel, featured: false, position: 12,
    cost_estimate: "$1,900 Business Trip",
    short_description: "Trade fairs (Canton Fair), business procurement tours, and study opportunities across China.",
    requirements: "Valid Passport\nBusiness Invitation Letter (M Visa)\nFlight & Hotel Confirmation"
  }
]

destinations_data.each do |attrs|
  dest = Destination.find_or_initialize_by(name: attrs[:name])
  dest.country_code = attrs[:country_code]
  dest.category = attrs[:category]
  dest.featured = attrs[:featured]
  dest.position = attrs[:position]
  dest.cost_estimate = attrs[:cost_estimate]
  dest.short_description = attrs[:short_description]
  dest.description = attrs[:short_description]
  dest.requirements = attrs[:requirements]
  dest.visa_required = true
  dest.published = true
  dest.save!

  attach_seed_image(dest, :hero_image, attrs[:hero_asset]) if attrs[:hero_asset].present?
end

# 6. Founder & Team Members
founder = TeamMember.find_or_initialize_by(name: "Mrs. Ify Adegoke")
founder.role = "Founder & CEO (Pst. Ifeoma Favour Adegoke, FAIPL)"
founder.bio = "Founder and Chief Executive Officer of NewPage Integrity Travels & Tours Limited. A respected travel industry leader, active NANTA Eastern Zone member, and Fellow of the African Institute of Public Leadership (FAIPL), Mrs. Ify Adegoke leads the agency with unwavering integrity, professionalism, and a passion for connecting clients to global travel, education, and business opportunities."
founder.email = "newpageintegritytravels@gmail.com"
founder.phone = "+234 803 865 6409"
founder.position = 1
founder.published = true
founder.save!
attach_seed_image(founder, :image, "founder-ify-adegoke-trophy.jpg")

advisory = TeamMember.find_or_initialize_by(name: "NewPage Advisory Team")
advisory.role = "Travel, Visa, Admissions & CAC Consultants"
advisory.bio = "Dedicated specialists guiding clients through domestic and international flight bookings, visa & residency documentation, overseas university admissions, and CAC corporate filings from our Warri Head Office."
advisory.email = "newpageintegritytravels@gmail.com"
advisory.phone = "+234 803 865 6409"
advisory.position = 2
advisory.published = true
advisory.save!

# 7. Awards & Recognition (Company & Founder/CEO)
awards_data = [
  {
    title: "Travel Agency of the Year Award",
    recipient_type: :company,
    recipient_name: "NewPage Integrity Travels & Tours Limited",
    issuing_organization: "National Association of Nigeria Travel Agencies (NANTA) — Eastern Zone",
    awarded_on: Date.new(2026, 11, 21),
    location: "Owerri, Imo State, Nigeria",
    category: "Industry Excellence",
    description: "Presented to NewPage Integrity Travels & Tours Limited at the NANTA Eastern Zonal AGM & End-of-the-Year Meeting (Owerri 2026) in recognition of outstanding service, professionalism, integrity, and meaningful contributions to the growth of Nigeria's travel industry.",
    featured: true,
    published: true,
    position: 1,
    image_asset: "award-nanta-agency-of-the-year-banner.jpg"
  },
  {
    title: "Fellowship of the African Institute of Public Leadership (FAIPL)",
    recipient_type: :founder,
    recipient_name: "Mrs. Ify Adegoke (Pst. Ifeoma Favour Adegoke, FAIPL)",
    issuing_organization: "African Institute of Public Leadership (AIPL)",
    awarded_on: Date.new(2026, 11, 14),
    location: "Nigeria",
    category: "Leadership Fellowship",
    description: "Conferred by the Governing Council of the African Institute of Public Leadership (AIPL) upon our Founder & CEO, Pst. Ifeoma Favour Adegoke (Mrs. Ify Adegoke), elevating her to the Fellowship of the Institute in honour and recognition of her commitment to exemplary leadership, professional excellence, institutional development, and service to humanity.",
    featured: true,
    published: true,
    position: 2,
    image_asset: "award-aipl-fellowship-ify-adegoke.jpg"
  }
]

awards_data.each do |attrs|
  award = Award.find_or_initialize_by(title: attrs[:title], issuing_organization: attrs[:issuing_organization])
  award.recipient_type = attrs[:recipient_type]
  award.recipient_name = attrs[:recipient_name]
  award.awarded_on = attrs[:awarded_on]
  award.location = attrs[:location]
  award.category = attrs[:category]
  award.description = attrs[:description]
  award.featured = attrs[:featured]
  award.published = attrs[:published]
  award.position = attrs[:position]
  award.save!

  attach_seed_image(award, :image, attrs[:image_asset]) if attrs[:image_asset].present?
end

# 8. Photo Gallery (NANTA Events, Awards Night, Awareness Walk, Founder & Campaigns)
gallery_data = [
  {
    title: "NANTA Eastern Zone Travel Agency of the Year Award",
    caption: "NewPage Integrity Travels & Tours Limited honoured as Travel Agency of the Year by NANTA Eastern Zone, Owerri 2026.",
    category: :events,
    position: 1,
    asset: "award-nanta-agency-of-the-year-banner.jpg"
  },
  {
    title: "Founder Mrs. Ify Adegoke With the NANTA Award Trophy",
    caption: "Our Founder & CEO, Mrs. Ify Adegoke, proudly holding the NANTA Eastern Zone Travel Agency of the Year crystal star trophy.",
    category: :events,
    position: 2,
    asset: "founder-ify-adegoke-trophy.jpg"
  },
  {
    title: "AIPL Leadership Fellowship — Pst. Ifeoma Favour Adegoke, FAIPL",
    caption: "Elevation of our Founder & CEO to the Fellowship of the African Institute of Public Leadership (AIPL), November 14, 2026.",
    category: :events,
    position: 3,
    asset: "award-aipl-fellowship-ify-adegoke.jpg"
  },
  {
    title: "NANTA Eastern Zone Awareness Walk — Verified Travel Advisors",
    caption: "Mrs. Ify Adegoke and fellow NANTA Eastern Zone members advocating 'Deal Only With Verified Travel Advisors' across the zone.",
    category: :events,
    position: 4,
    asset: "nanta-awareness-walk.jpg"
  },
  {
    title: "Mrs. Ify Adegoke Addressing Delegates at NANTA Owerri 2026",
    caption: "Our Founder & CEO speaking on stage at the NANTA Eastern Zonal AGM & End-of-the-Year Meeting in Owerri, Imo State.",
    category: :events,
    position: 5,
    asset: "nanta-agm-founder-speaking.jpg"
  },
  {
    title: "NANTA Awards Night Celebration",
    caption: "Celebrating the Travel Agency of the Year honour with industry colleagues and NANTA Eastern Zone executives.",
    category: :events,
    position: 6,
    asset: "nanta-awards-night-group.jpg"
  },
  {
    title: "Travel Agency of the Year Crystal Trophy",
    caption: "Close-up of the prestigious NANTA Eastern Zone Travel Agency of the Year Award presented to NewPage Integrity Travels.",
    category: :events,
    position: 7,
    asset: "award-nanta-trophy-closeup.jpg"
  },
  {
    title: "NANTA Eastern Zonal AGM — Owerri 2026",
    caption: "Mrs. Ify Adegoke representing NewPage Integrity Travels at the NANTA Owerri 2026 Annual Conference & Exhibition.",
    category: :events,
    position: 8,
    asset: "nanta-agm-backdrop-pose.jpg"
  },
  {
    title: "Strengthening Professionalism in the Travel Industry",
    caption: "On stage at the NANTA Eastern Zonal AGM, 19th–22nd November 2026, Owerri, Imo State.",
    category: :events,
    position: 9,
    asset: "nanta-agm-stage-portrait.jpg"
  },
  {
    title: "NANTA Owerri 2026 — Delegates Networking",
    caption: "Connecting with fellow verified travel advisors during the NANTA Eastern Zone AGM sessions.",
    category: :events,
    position: 10,
    asset: "nanta-agm-colleagues.jpg"
  },
  {
    title: "Conference Session at NANTA Owerri 2026",
    caption: "Participating in strategic industry sessions on partnerships and sustainable growth in travel.",
    category: :events,
    position: 11,
    asset: "nanta-agm-conference-session.jpg"
  },
  {
    title: "NANTA Eastern Zone 2026 Participant Accreditation",
    caption: "Official participant pass for the NANTA Eastern Zone 2026 End-of-the-Year Meeting at McDon Skye Hotels, Owerri.",
    category: :events,
    position: 12,
    asset: "nanta-agm-participant-badge.jpg"
  },
  {
    title: "Study • Travel • Explore With NewPage Integrity",
    caption: "Your Journey, Our Commitment — international admissions, flights, visas, and tours from Warri to the world.",
    category: :travel,
    position: 13,
    asset: "brand-study-travel-explore.jpg"
  },
  {
    title: "Domestic Flight Deals Across All Nigerian States",
    caption: "Book Ibom Air, Air Peace, Azman Air, MaxAir, Arik, Dana Air, and Aero through NewPage Integrity Travels.",
    category: :travel,
    position: 14,
    asset: "flights-domestic-nigeria.jpg"
  },
  {
    title: "Study in Malaysia — Complete Student Guide",
    caption: "Answers to 15 frequently asked questions for Nigerian students planning to study in Malaysia.",
    category: :students,
    position: 15,
    asset: "study-malaysia-faqs.jpg"
  }
]

gallery_data.each do |attrs|
  gi = GalleryImage.find_or_initialize_by(title: attrs[:title])
  gi.caption = attrs[:caption]
  gi.category = attrs[:category]
  gi.position = attrs[:position]
  gi.published = true
  gi.save!

  attach_seed_image(gi, :image, attrs[:asset])
end

# 9. Testimonials
[
  { client_name: "Adeola Balogun", service_type: :study, rating: 5, content: "NewPage Integrity Travels made my UK study visa and university admission completely stress-free. Their attention to every document detail is unmatched!" },
  { client_name: "Emeka Okoro", service_type: :cac, rating: 5, content: "Got my CAC Limited Liability Company, TIN, and SCUML registered swiftly with zero hidden charges. Highly professional and transparent team in Warri." },
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

# 10. FAQs (Including Study in Malaysia, St. Clair 2027, Southampton Scholarships & CAC)
faqs_data = [
  { question: "How long does a UK or Canada study visa application take?", answer: "Standard UK student visa decisions take approximately 3 weeks after biometrics (with 5-day priority options). Canada study permits typically take 6–12 weeks depending on season.", category: :visas },
  { question: "Can I study abroad in the UK or Canada without IELTS?", answer: "Yes. Many partner universities in the UK, Canada (including Algoma University's English test exemption for Nigerian students), and Europe accept WAEC/NECO English or a Medium of Instruction letter in place of IELTS.", category: :study_abroad },
  { question: "What are the benefits of applying to St. Clair College (Canada) for 2027?", answer: "Eligible applicants enjoy a 100% application fee waiver (saving $125), priority offer processing (2–5 days), 6 months of complimentary hostel accommodation, free transportation and health insurance, paid internship opportunities, and PGWP/PR-aligned programmes such as Personal Support Worker (H932) and Cybersecurity & Automobility (T891).", category: :study_abroad },
  { question: "How does the University of Southampton 2027 Adult Nursing Scholarship work?", answer: "The University of Southampton offers an automatic £5,000 per year Global Talent in Adult Nursing Scholarship for eligible new self-funded international students entering in 2027 — covering up to 3 years for BSc Adult Nursing and up to 2 years for MSc Adult Nursing, with no separate scholarship application required.", category: :study_abroad },
  { question: "Can Nigerian students apply to study in Malaysia with WAEC, NECO, or HND?", answer: "Yes. Malaysian universities accept Nigerian students with WAEC/NECO for foundation, diploma, or bachelor's programmes, and HND holders may qualify for bachelor's top-up/advanced entry or postgraduate programmes depending on the institution. Annual tuition ranges roughly from RM20,000 to RM60,000+, with monthly living costs around RM1,500–RM2,500.", category: :study_abroad },
  { question: "What do I need for CAC Business Name, Company, NGO, or Annual Returns filing?", answer: "For new registrations, you need two proposed names, a valid government-issued ID (NIN, International Passport, or Driver's License), passport photograph, signature specimen, and address. For Annual Returns, Change of Director, Company Upgrade, TIN, Tax Clearance, or SCUML, provide your CAC registration number and status report.", category: :cac },
  { question: "Do you handle flight bookings, airport shuttles, and travel insurance?", answer: "Yes. We book domestic flights across all Nigerian airlines and international flights worldwide, alongside hotel reservations, local and international airport shuttles, international passport assistance, and embassy-compliant travel health insurance.", category: :travel }
]

faqs_data.each_with_index do |attrs, idx|
  faq = Faq.find_or_initialize_by(question: attrs[:question])
  faq.answer = attrs[:answer]
  faq.category = attrs[:category]
  faq.position = idx + 1
  faq.published = true
  faq.save!
end

# 11. Blog Posts (Including the dedicated Ebola Public Health Awareness Blog Post)
ebola_body = <<~HTML
  <p>As a responsible international travel and consulting agency, <strong>NewPage Integrity Travels &amp; Tours Limited</strong> prioritizes the health, safety, and well-being of every traveler, student, and family we serve. Staying informed with accurate, verified public health facts is one of the most effective ways to protect yourself and your community — both at home and while traveling across borders.</p>

  <p>Below is a practical public health guide based on the <strong>"Ebola: Know the Facts — Help Stop the Spread"</strong> awareness initiative (supported by <em>La Plage Meta Verse</em>).</p>

  <h3>How Ebola Spreads</h3>
  <p>Ebola Virus Disease (EVD) is <strong>not</strong> spread through ordinary casual contact, air, or water. It spreads through:</p>
  <ul>
    <li>Direct contact with the blood or body fluids of a person who is sick with Ebola.</li>
    <li>Direct contact with objects or surfaces contaminated with infected body fluids.</li>
    <li>Contact with infected sick or dead wildlife.</li>
  </ul>
  <p><strong>Important Fact:</strong> People do <em>not</em> spread Ebola before symptoms begin.</p>

  <h3>Signs &amp; Symptoms to Watch For</h3>
  <p>Symptoms can appear anywhere from <strong>2 to 21 days</strong> after exposure. Early warning signs include:</p>
  <ul>
    <li>Sudden fever and severe tiredness (fatigue)</li>
    <li>Headache and muscle pain</li>
    <li>Sore throat</li>
    <li>Vomiting or diarrhoea</li>
  </ul>
  <p><em>Note:</em> Bleeding does not occur in every case, so never wait for severe symptoms before seeking guidance.</p>

  <h3>How to Protect Yourself &amp; Your Family</h3>
  <ul>
    <li>Wash your hands frequently and thoroughly with soap and clean water or an alcohol-based hand sanitizer.</li>
    <li>Avoid direct contact with blood or body fluids of anyone who is unwell.</li>
    <li>Do not touch the body of someone who may have died from Ebola.</li>
    <li>Avoid touching or handling sick or dead wildlife.</li>
    <li>Follow airport and border health screening advisories whenever traveling internationally.</li>
  </ul>

  <h3>What to Do If You Are Exposed or Symptomatic</h3>
  <p>If you believe you have been exposed or begin experiencing symptoms, <strong>avoid close contact with others</strong> immediately. <strong>Call NCDC 6232</strong> (Nigeria Centre for Disease Control) or your State Ministry of Health right away for official instructions. <strong>Do not visit a clinic or hospital without calling ahead first</strong>, so healthcare teams can prepare safely and protect other patients.</p>

  <p><strong>Early medical care significantly improves survival.</strong> Share verified facts, stay calm, and travel safely. For travel health insurance and pre-departure travel safety guidance, contact NewPage Integrity Travels &amp; Tours Limited on <strong>08038656409</strong>.</p>
HTML

blog_posts_data = [
  {
    title: "Ebola: Know the Facts — Essential Travel Health & Prevention Guide",
    category: "Travel Health & Safety",
    excerpt: "Understand how Ebola spreads, the early symptoms to watch for, practical prevention steps, and what to do if exposed — including NCDC 6232 emergency guidance.",
    tags: "travel health, ebola awareness, ncdc 6232, public health nigeria, safe travel",
    featured: true,
    featured_asset: "blog-ebola-know-the-facts.jpg",
    published_at: Time.current,
    body: ebola_body
  },
  {
    title: "Complete Guide to Studying in the UK from Nigeria",
    category: "Study Abroad",
    excerpt: "Everything Nigerian students need to know about UK university admissions, University of Southampton £5,000/yr Adult Nursing scholarships, WAEC English waivers, and student visa timelines.",
    tags: "uk study visa, study abroad nigeria, southampton scholarship, admissions",
    featured: true,
    featured_asset: "study-uk-southampton-nursing.jpg",
    published_at: 3.days.ago,
    body: "Studying in the United Kingdom remains one of the smartest investments for Nigerian students seeking globally recognized degrees and the 2-year Graduate Route work visa. For 2027 entry, the University of Southampton is offering an automatic £5,000 per year Global Talent in Adult Nursing Scholarship (up to 3 years for BSc and 2 years for MSc). Start by shortlisting accredited universities, preparing your transcripts and Statement of Purpose, and ensuring your maintenance funds meet UKVI's 28-day rule."
  },
  {
    title: "5 Common Visa Mistakes That Cause Rejections — And How to Avoid Them",
    category: "Visa Updates",
    excerpt: "Avoid preventable visa refusals by mastering financial documentation, strong home ties, and consistent application forms.",
    tags: "visa tips, embassy interview, travel agency warri",
    featured: true,
    published_at: 7.days.ago,
    body: "Most tourist and student visa refusals stem from avoidable documentation errors: unexplained lump-sum deposits in bank statements, inconsistent travel histories, or poorly articulated travel purposes. Working with an experienced, NANTA-verified visa consultant ensures your application tells a clear, verifiable story."
  },
  {
    title: "Why Registering Your Business with CAC Unlocks Corporate Growth",
    category: "Business & CAC",
    excerpt: "From corporate bank accounts and SCUML compliance to embassy credibility and SME grants, here is why formalizing your Nigerian business pays off immediately.",
    tags: "cac registration warri, business name, scuml, annual returns",
    featured: false,
    featured_asset: "cac-services-flyer.jpg",
    published_at: 12.days.ago,
    body: "Whether you run a growing venture in Warri or an international consulting brand, CAC registration gives your business legal standing, corporate banking access, and stronger credibility with clients, investors, and embassies. Remember to stay current with your Annual Returns, TIN, Tax Clearance Certificate, and SCUML certification."
  }
]

blog_posts_data.each do |attrs|
  bp = BlogPost.find_or_initialize_by(title: attrs[:title])
  bp.blog_category = categories[attrs[:category]]
  bp.author = admin
  bp.excerpt = attrs[:excerpt]
  bp.tags = attrs[:tags]
  bp.body = attrs[:body]
  bp.status = :published
  bp.published_at ||= attrs[:published_at]
  bp.featured = attrs[:featured]
  bp.save!

  attach_seed_image(bp, :featured_image, attrs[:featured_asset]) if attrs[:featured_asset].present?
end

puts "=== Seed Complete! ==="
puts "Services: #{Service.count} | Destinations: #{Destination.count} | Awards: #{Award.count} | Gallery: #{GalleryImage.count} | BlogPosts: #{BlogPost.count} | Team: #{TeamMember.count}"
