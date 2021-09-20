class CreateMovementRecurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table :movement_recurrencies do |t|
      t.date :date
      t.belongs_to :financial_movement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
