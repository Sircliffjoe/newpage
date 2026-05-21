FactoryBot.define do
  factory :team_member do
    name { "MyString" }
    role { "MyString" }
    bio { "MyText" }
    photo { "MyString" }
    position { 1 }
    published { false }
  end
end
