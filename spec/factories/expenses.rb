FactoryBot.define do
  factory :expense do
    title { 'Controle financeiro' }
    description { Faker::Loren.sentence }
    date { Date.today }
    amount { Faker::Number.decimal(l_digits: 3, r_digits: 2)}
    expense_type { 1 }
    duration {}
    financial_control { create(:financial_control) }
  end
end
