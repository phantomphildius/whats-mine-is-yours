class CreateBudgetItemTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :budget_item_transactions do |t|
      t.references :budget_item, null: false, foreign_key: true
      t.references :statement_transaction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
