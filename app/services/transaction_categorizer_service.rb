class TransactionCategorizerService
  def initialize(statement_transaction:, budget:)
    @statement_transaction = statement_transaction
    @budget = budget
  end

  def categorize
    BudgetItemTransaction.create!(
      budget_item: budget_item_for_transaction,
      statement_transaction: statement_transaction,
    )
  end

  private

  attr_reader :statement_transaction, :budget

  def budget_item_for_transaction
    budget.items.for_transaction(statement_transaction).first
  end
end
