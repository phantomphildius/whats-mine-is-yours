class BudgetItemTransaction < ApplicationRecord
  belongs_to :budget_item
  belongs_to :statement_transaction
end
