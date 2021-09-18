class FinancialMovement < ApplicationRecord
  belongs_to :financial_control

  validates :name, :amount, :movement_type, presence: true
  enum movement_type: { revenue: 0, expense: 1 }
end
