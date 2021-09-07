class FinancialControl < ApplicationRecord
  belongs_to :user

  include FinancialControlAdmin
end
