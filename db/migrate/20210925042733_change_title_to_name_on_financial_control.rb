class ChangeTitleToNameOnFinancialControl < ActiveRecord::Migration[6.1]
  def change
    rename_column :financial_controls, :title, :name
  end
end
