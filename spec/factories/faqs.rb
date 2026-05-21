FactoryBot.define do
  factory :faq do
    question { "MyString" }
    answer { "MyText" }
    category { 1 }
    position { 1 }
    published { false }
  end
end
