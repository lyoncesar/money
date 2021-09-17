FactoryBot.define do
  factory :revenue do
    title { 'Adiantamento de salário' }
    description { Faker::Loren.sentence }
    date { Date.today }
    amount { Faker::Number.decimal(l_digits: 4, r_digits: 2)}
    expense_type { 1 }
    duration {}
    financial_control { create(:financial_control) }
  end
end
