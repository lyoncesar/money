class Expense < ApplicationRecord
  belongs_to :financial_control

  validates :title, :amount, :expense_type, presence: true

  enum expense_type: { temporary: 0, fixed: 1}
end
