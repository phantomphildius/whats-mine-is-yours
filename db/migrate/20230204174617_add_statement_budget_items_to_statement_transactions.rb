class AddStatementBudgetItemsToStatementTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :statement_transactions, :statement_budget_item, null: true, foreign_key: true
  end
end
