FactoryBot.define do
  factory :financial_control do
    title { 'Financial control' }
    description { Faker::Lorem.sentence }
    user { create(:user) }
  end
end
