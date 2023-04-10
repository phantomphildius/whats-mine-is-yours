class StatementBudgetItemBackfillJob < ApplicationJob
  def perform(budget_item:, budget:)
    budget
      .monthly_statements
      .includes(:statements)
      .find_each do |monthly_statement|
        monthly_statement.statements.each do |statement|
          StatementBackfillCategorizationJob.perform_later(
            statement: statement,
            budget_item: budget_item
          )
        end
      end
  end
end
