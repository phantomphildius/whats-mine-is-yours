class AddNullConstraints < ActiveRecord::Migration[7.0]
  def change
    change_column_null :budget_items, :category, false
    change_column_null :budget_items, :amount_cents, false
    change_column_null :statement_transactions, :category, false
    change_column_null :statement_transactions, :amount_cents, false
    change_column_null :statement_transactions, :date, false
    change_column_null :statement_transactions, :merchant, false
    change_column_null :statements, :institution, false
    change_column_null :statements, :time_period, false
  end
end
