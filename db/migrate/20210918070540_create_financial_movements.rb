class CreateFinancialMovements < ActiveRecord::Migration[6.1]
  def change
    create_table :financial_movements do |t|
      t.string :name, default: ''
      t.string :description, default: ''
      t.float :amount, default: 0.0
      t.date :date
      t.integer :movement_type, null: false
      t.string :duration, default: '', null: false
      t.belongs_to :financial_control, null: false, foreign_key: true

      t.timestamps
    end
  end
end
