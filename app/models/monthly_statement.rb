class MonthlyStatement < ApplicationRecord
  belongs_to :budget
  has_many :statements

  has_many :transactions, through: :statements

  def total
    Money.new(statements.joins(:transactions).sum('statement_transactions.amount_cents'))
  end

  def categorized_totals
    transactions
      .left_joins(:statement_budget_item)
      .group('statement_budget_items.budget_item_id')
      .sum(:amount_cents)
      .transform_keys { |key| BudgetItem.find_by(id: key)&.category || 'Uncategorized' }
  end

  def met_budget?
    total < budget.total
  end

  def to_partial_path
    'statements/monthly_statement'
  end

  def to_display
    MonthlyStatementPresenter.new(self)
  end
end
