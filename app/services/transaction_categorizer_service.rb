class TransactionCategorizerService
  def initialize(statement_transaction:, budget:, statement:)
    @statement_transaction = statement_transaction
    @budget = budget
    @statement = statement
  end

  def categorize
    statement_transaction.update!(statement_budget_item: statement_budget_item)
  end

  private

  attr_reader :statement_transaction, :budget, :statement

  def statement_budget_item
    statement.budget_items.find_by!(budget_item: budget_item_for_transaction)
  end

  def budget_item_for_transaction
    budget.items.for_transaction(statement_transaction).first
  end
end
