class StatementBudgetItem < ApplicationRecord
  belongs_to :budget_item
  belongs_to :statement

  has_many :statement_transactions

  delegate :category, to: :budget_item, prefix: true

  def self.category_for_transaction(id)
    if id.present?
      StatementBudgetItem.find(id).budget_item_category
    else
      'Uncategorized'
    end
  end
end
