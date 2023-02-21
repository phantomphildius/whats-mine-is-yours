class StatementImporterService
  def initialize(institution_name:, statement_file:, budget:, time_period:)
    @institution_name = institution_name
    @statement_file = statement_file
    @budget = budget
    @time_period = time_period
  end

  def import
    budget.transaction do
      institution.save!
      statement.save!
      create_statement_budget_items!
      create_statement_transactions!
      StatementCategorizerJob.perform_later(statement: statement, budget: budget)
    end
  end

  def monthly_statement
    @monthly_statement ||= MonthlyStatement.find_or_create_by!(
      time_period: Date.parse(time_period),
      budget: budget,
    )
  end

  private

  attr_reader :institution_name, :statement_file, :budget, :time_period

  def statement
    @statement ||= monthly_statement.statements.build(
      monthly_statement: monthly_statement,
      institution: institution,
      time_period: Date.parse(time_period),
    )
  end

  # TODO: may need to create parser per institution
  #
  def institution
    @institution ||= Institution.find_or_initialize_by(name: institution_name.downcase)
  end

  def create_statement_budget_items!
    budget.items.each { |item| item.statement_budget_items.create!(statement: statement) }
  end

  # TODO: candidate to run asynchronously in background
  #
  def create_statement_transactions!
    statement_parser.transaction_rows.each do |transaction|
      statement.transactions.create!(transaction)
    end
  end

  def statement_parser
    StatementParserService.new(statement_file)
  end
end
