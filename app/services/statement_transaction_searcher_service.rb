class StatementTransactionSearcherService
  def initialize(monthly_statement, search_criteria)
    @monthly_statement = monthly_statement
    @search_criteria = search_criteria
  end

  attr_reader :transactions

  def execute
    @transactions = monthly_statement.transactions.order(:date).page(page)
  end

  private

  attr_reader :monthly_statement, :search_criteria
  delegate :page, to: :search_criteria
end
