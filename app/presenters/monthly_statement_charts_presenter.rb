class MonthlyStatementChartsPresenter
  def initialize(monthly_statement, chart_type)
    @monthly_statement = monthly_statement
    @chart_type = chart_type
  end

  def build_chart
    chart_type_class.new(monthly_statement).execute
  end

  private

  attr_reader :monthly_statement, :chart_type

  def chart_type_class
    case chart_type.to_sym
    when :progress
      DailyChart
    when :donut
      DonutChart
    when :bar
      BarChart
    else
      raise "Chart type not implemented"
    end
  end

  class CategorizedChart
    def initialize(monthly_statement)
      @monthly_statement = monthly_statement
    end

    def execute
      raise NotImplementedError
    end

    private

    def categorized_totals
      @monthly_statement
        .transactions
        .left_joins(:statement_budget_item)
        .group("statement_budget_items.budget_item_id")
        .sum(:amount_cents)
    end
  end

  class DonutChart < CategorizedChart
    def execute
      categorized_totals.each_with_object({}) do |(key, value), obj|
        new_name = BudgetItem.find_by(id: key)&.category || "Uncategorized"
        obj[new_name] = value / 100
      end
    end
  end

  class BarChart < CategorizedChart
    def execute
      categorized_totals
        .except(nil)
        .each_with_object({}) do |(key, value), obj|
          budget_item = BudgetItem.find_by(id: key)
          obj[budget_item.category] = (
            value.to_d / budget_item.amount_cents.to_d
          ) * 100
        end
    end
  end

  class DailyChart
    def initialize(monthly_statement)
      @monthly_statement = monthly_statement
    end

    def execute
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

    private

    attr_reader :monthly_statement

    delegate :time_period, :transactions, to: :monthly_statement
  end
end
