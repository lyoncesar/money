module FinancialControlAdmin
  extend ActiveSupport::Concern

  included do
    rails_admin do
      list do
        exclude_fields :created_at, :udpated_at
      end
    end
  end
end
