FactoryBot.define do
  factory :testimonial do
    client_name { "MyString" }
    content { "MyText" }
    rating { 1 }
    photo { "MyString" }
    service_type { 1 }
    published { false }
    position { 1 }
  end
end
