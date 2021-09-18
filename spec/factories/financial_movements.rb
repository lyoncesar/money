FactoryBot.define do
  factory :financial_movement do
    name { "Salário" }
    description { Faker::Lorem.sentence }
    amount { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    date { Date.today }
    movement_type { :revenue }
    duration { 'permanent' }
    financial_control { create(:financial_control) }

    trait :expense do
      name { "Aluguel" }
      description { Faker::Lorem.sentence }
      amount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
      movement_type { :expense }
    end
  end
end
