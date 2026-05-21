FactoryBot.define do
  factory :blog_post do
    title { "MyString" }
    slug { "MyString" }
    excerpt { "MyText" }
    blog_category { nil }
    tags { "MyString" }
    status { 1 }
    published_at { "2026-05-21 16:29:54" }
    author { nil }
    featured_image { "MyString" }
  end
end
