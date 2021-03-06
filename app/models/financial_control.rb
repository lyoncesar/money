class FinancialControl < ApplicationRecord
  belongs_to :user
  has_many :financial_movements, dependent: :destroy

  include FinancialControlAdmin

  validates :name, presence: true, length: { in: 3..255 }
end
