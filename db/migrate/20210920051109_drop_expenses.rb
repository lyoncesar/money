class DropExpenses < ActiveRecord::Migration[6.1]
  def change
    drop_table :expenses
  end
end
