# db/seeds.rb
puts "Creating Admin User..."
admin = User.find_or_create_by!(email: "admin@newpageintegrity.com") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
  u.first_name = "Super"
  u.last_name = "Admin"
  u.role = :super_admin
end

puts "Creating Blog Categories..."
travel_cat = BlogCategory.find_or_create_by!(name: "Travel Tips")
visa_cat = BlogCategory.find_or_create_by!(name: "Visa Updates")
study_cat = BlogCategory.find_or_create_by!(name: "Study Abroad")
cac_cat = BlogCategory.find_or_create_by!(name: "Business & CAC")

puts "Creating Services..."
Service.find_or_create_by!(title: "Global Flight Ticketing") do |s|
  s.category = :travel
  s.description = "We offer competitive rates for local and international flights, ensuring a seamless booking experience tailored to your itinerary."
  s.benefits = "24/7 Support\nBest Price Guarantee\nFlexible Rebooking"
  s.published = true
end

Service.find_or_create_by!(title: "UK Study Visa Assistance") do |s|
  s.category = :study_abroad
  s.description = "Expert guidance on securing your UK Tier 4 student visa, including CAS verification, financial document review, and IHS payment assistance."
  s.benefits = "High Approval Rate\nDocument Verification\nInterview Prep"
  s.requirements = "Valid Passport\nCAS Letter\nProof of Funds\nTB Test Certificate"
  s.published = true
end

Service.find_or_create_by!(title: "Business Name Registration") do |s|
  s.category = :cac
  s.description = "Fast and reliable registration of your business name with the Corporate Affairs Commission in Nigeria. Ideal for sole proprietors and partnerships."
  s.benefits = "Certificate in 7 Days\nTIN Included\nFree Consultation"
  s.requirements = "2 Proposed Names\nValid ID Card\nPassport Photograph\nSignature Specimen"
  s.published = true
end

puts "Creating Destinations..."
Destination.find_or_create_by!(name: "United Kingdom") do |d|
  d.country_code = "GB"
  d.category = :study
  d.description = "Home to world-renowned universities and a vibrant multicultural environment. The UK remains a top choice for international students."
  d.cost_estimate = "£12,000 / year"
  d.published = true
end

Destination.find_or_create_by!(name: "Canada") do |d|
  d.country_code = "CA"
  d.category = :travel
  d.description = "Discover immense opportunities for study, work, and permanent residency in one of the world's most welcoming countries."
  d.cost_estimate = "$15,000 CAD"
  d.published = true
end

puts "Creating Testimonials..."
Testimonial.find_or_create_by!(client_name: "Adeola B.") do |t|
  t.content = "Newpage Integrity Travels made my UK study visa application completely stress-free. Their attention to detail is unmatched!"
  t.service_type = :study
  t.rating = 5
  t.published = true
end

Testimonial.find_or_create_by!(client_name: "Emeka Okoro") do |t|
  t.content = "Got my CAC business name registered in exactly 7 days just as promised. Very professional and transparent."
  t.service_type = :cac
  t.rating = 5
  t.published = true
end

puts "Creating FAQs..."
Faq.find_or_create_by!(question: "How long does a US tourist visa application take?") do |f|
  f.answer = "The process involves filling the DS-160 and booking an appointment. While the form takes a few days, appointment wait times vary by embassy location."
  f.category = "visas"
  f.published = true
end

Faq.find_or_create_by!(question: "Can I study abroad without IELTS?") do |f|
  f.answer = "Yes, many universities in the UK, USA, and Canada accept WAEC/NECO English grades (C6 and above) in lieu of IELTS, depending on the institution."
  f.category = "study_abroad"
  f.published = true
end

puts "Seed complete!"
