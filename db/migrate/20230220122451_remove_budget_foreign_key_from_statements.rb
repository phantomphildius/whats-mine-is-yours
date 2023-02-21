class RemoveBudgetForeignKeyFromStatements < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :statements, :budgets
    remove_column :statements, :budget_id
  end
end
