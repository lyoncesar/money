class FinancialControl < ApplicationRecord
  belongs_to :user
  has_many :expenses

  include FinancialControlAdmin
end
