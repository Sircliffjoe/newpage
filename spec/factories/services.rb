FactoryBot.define do
  factory :service do
    title { "MyString" }
    slug { "MyString" }
    category { 1 }
    description { "MyText" }
    hero_image { "MyString" }
    benefits { "MyText" }
    requirements { "MyText" }
    faq { "" }
    position { 1 }
    published { false }
  end
end
