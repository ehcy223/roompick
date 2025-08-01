FactoryBot.define do
  factory :post do
    user { nil }
    category { nil }
    title { "MyString" }
    body { "MyText" }
    rating { 1 }
  end
end
