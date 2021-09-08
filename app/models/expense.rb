class Expense < ApplicationRecord
  belongs_to :financial_control

  enum type: { temporary: 0, fixed: 1}
end
