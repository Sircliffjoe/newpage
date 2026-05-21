FactoryBot.define do
  factory :gallery_image do
    title { "MyString" }
    caption { "MyText" }
    category { 1 }
    position { 1 }
    published { false }
  end
end
