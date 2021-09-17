class Revenue < ApplicationRecord
  belongs_to :financial_control

  validates :title, :amount, :revenue_type, presence: true

  enum revenue_type: { temporary: 0, fixed: 1 }
end
