class MonthlyStatementPresenter
  delegate :time_period, :met_budget?, :total, to: :monthly_statement

  def initialize(monthly_statement)
    @monthly_statement = monthly_statement
  end

  def institution_names
    statements.joins(:institution).pluck("institutions.name").map(&:humanize)
  end

  def to_partial_path
    "statements/monthly_statement"
  end

  def to_param
    monthly_statement.id
  end

  private

  attr_reader :monthly_statement

  delegate :statements, to: :monthly_statement
end
