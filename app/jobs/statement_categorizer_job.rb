class StatementCategorizerJob < ApplicationJob
  def perform(statement)
    budget = statement.budget 
    statement.transactions.find_each do |transaction|
      StatementCategorizerService.new(
        budget: budget, 
        statement_transaction: transaction,
      ).categorize
    end
  end
end