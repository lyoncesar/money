class DropRevenue < ActiveRecord::Migration[6.1]
  def change
    drop_table :revenues
  end
end
