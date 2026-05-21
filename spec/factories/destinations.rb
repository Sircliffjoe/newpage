FactoryBot.define do
  factory :destination do
    name { "MyString" }
    slug { "MyString" }
    country_code { "MyString" }
    description { "MyText" }
    hero_image { "MyString" }
    requirements { "MyText" }
    cost_estimate { "MyString" }
    category { 1 }
    position { 1 }
    published { false }
  end
end
