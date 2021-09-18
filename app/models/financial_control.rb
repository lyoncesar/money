class FinancialControl < ApplicationRecord
  belongs_to :user
  has_many :revenues, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :financial_movements, dependent: :destroy

  include FinancialControlAdmin

  validates :title, presence: true, length: { in: 3..255 }
end
