class MonthlyStatement < ApplicationRecord
  belongs_to :budget
  has_many :statements

  def total
    Money.new(statements.joins(:transactions).sum('statement_transactions.amount_cents'))
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
