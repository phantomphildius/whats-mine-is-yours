class CreateStatementBudgetItems < ActiveRecord::Migration[7.0]
  def change
    create_table :statement_budget_items do |t|
      t.references :budget_item, null: false, foreign_key: true
      t.references :statement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
