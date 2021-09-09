class FinancialControl < ApplicationRecord
  belongs_to :user
  has_many :revenues, dependent: :destroy
  has_many :expenses, dependent: :destroy

  include FinancialControlAdmin
end
