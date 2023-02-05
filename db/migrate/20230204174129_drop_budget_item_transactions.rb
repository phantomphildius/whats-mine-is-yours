class DropBudgetItemTransactions < ActiveRecord::Migration[7.0]
  def change
    drop_table :budget_item_transactions
  end
end
