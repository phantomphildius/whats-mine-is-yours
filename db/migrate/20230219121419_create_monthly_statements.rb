class CreateMonthlyStatements < ActiveRecord::Migration[7.0]
  def change
    create_table :monthly_statements do |t|
      t.date :time_period, null: false, index: true
      t.references :budget, foreign_key: true

      t.timestamps
    end
  end
end
