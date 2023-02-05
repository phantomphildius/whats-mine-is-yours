class StatementBudgetItem < ApplicationRecord
  belongs_to :budget_item
  belongs_to :statement

  has_many :statement_transactions
end
