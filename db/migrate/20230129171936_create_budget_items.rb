class CreateBudgetItems < ActiveRecord::Migration[7.0]
  def change
    create_table :budget_items do |t|
      t.references :budget, null: false, foreign_key: true
      t.string :category
      t.integer :amount_cents

      t.timestamps
    end
  end
end
