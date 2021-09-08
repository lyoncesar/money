class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.string :title, default: ''
      t.string :description, default: ''
      t.date :date
      t.float :amount, default: 0.0
      t.integer :expense_type, default: 0
      t.string :duration, default: ''
      t.belongs_to :financial_control, null: false, foreign_key: true

      t.timestamps
    end
  end
end
