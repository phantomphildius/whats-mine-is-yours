class StatementBackfillCategorizationJob < ApplicationJob
  def perform(budget_item:, statement:)
    statement.with_lock do
      statement.budget_items.create!(budget_item: budget_item)
      StatementCategorizerJob.perform_later(
        statement: statement,
        budget: budget_item.budget
      )
    end
  end
end
