class FinancialMovement < ApplicationRecord
  belongs_to :financial_control
  has_many :movement_recurrencies, dependent: :destroy

  validates :name, :amount, :movement_type, presence: true
  enum movement_type: { revenue: 0, expense: 1 }

  include FinancialMovementAdmin
end
