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
      StatementCategorizerJob.perform_later(statement)
    end
  end

  def statement
    @statement ||= budget.statements.build(
      institution: institution,
      time_period: Date.strptime(time_period, '%m/%y'),
    )
  end

  private

  attr_reader :institution_name, :statement_file, :budget, :time_period

  def institution
    @institution ||= Institution.find_or_initialize_by(name: institution_name.downcase)
  end

  def create_statement_budget_items!
    budget.items.each { |item| item.statement_budget_items.create!(statement: statement) }
  end

  # candidate to run asynchronously in background
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