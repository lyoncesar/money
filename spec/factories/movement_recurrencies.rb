FactoryBot.define do
  factory :movement_recurrency do
    date { Date.today + 1.month }
    financial_movement { create(:financial_movement, :expense) }
  end
end
