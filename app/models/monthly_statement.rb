class MonthlyStatement < ApplicationRecord
  belongs_to :budget
  has_many :statements

  has_many :transactions, through: :statements

  def total
    Money.new(
      statements.joins(:transactions).sum("statement_transactions.amount_cents")
    )
  end

  # move this to a helper or presenter

  def categorized_totals
    _categorized_totals.each_with_object({}) do |(key, value), obj|
      new_name = BudgetItem.find_by(id: key)&.category || "Uncategorized"
      obj[new_name] = value / 100
    end
  end

  def monthly_budget_utlization_by_category
    # binding.pry
    _categorized_totals
      .except(nil)
      .each_with_object({}) do |(key, value), obj|
        budget_item = BudgetItem.find_by(id: key)
        obj[budget_item.category] = (
          value.to_d / budget_item.amount_cents.to_d
        ) * 100
      end
  end

  def daily_spend_over_a_month
    days_in_month = Time.days_in_month(time_period.month)
    collection = (1..days_in_month).to_a
    start_date = time_period.beginning_of_month

    collection.each_with_object({}) do |day, obj|
      end_date_string = time_period.strftime("%Y-%m") + "-#{day}"
      obj[day] = transactions.where(
        date: start_date..(Date.parse(end_date_string))
      ).sum(:amount_cents) / 100
    end
  end

  def met_budget?
    total < budget.total
  end

  def to_partial_path
    "statements/monthly_statement"
  end

  def to_display
    MonthlyStatementPresenter.new(self)
  end

  private

  def _categorized_totals
    @_categorized_totals ||=
      transactions
        .left_joins(:statement_budget_item)
        .group("statement_budget_items.budget_item_id")
        .sum(:amount_cents)
  end
end
