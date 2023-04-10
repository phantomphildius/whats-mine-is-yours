class StatementCategorizerJob < ApplicationJob
  def perform(statement:, budget:)
    statement.transactions.uncategorized.find_each do |transaction|
      TransactionCategorizerService.new(
        budget: budget,
        statement: statement,
        statement_transaction: transaction
      ).categorize
    end
  end
end
