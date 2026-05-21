FactoryBot.define do
  factory :lead do
    name { "MyString" }
    email { "MyString" }
    phone { "MyString" }
    service_type { 1 }
    message { "MyText" }
    status { 1 }
    notes { "MyText" }
    source { "MyString" }
  end
end
