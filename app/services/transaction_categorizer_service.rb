class TransactionCategorizerService
  def initialize(statement_transaction:, budget:, statement:, budget_item_id: nil)
    @statement_transaction = statement_transaction
    @budget = budget
    @statement = statement
    @budget_item_id = budget_item_id
  end

  def categorize
    statement_transaction.update!(statement_budget_item: statement_budget_item)
  end

  private

  attr_reader :statement_transaction, :budget, :statement, :budget_item_id

  def statement_budget_item
    if budget_item_id.present?
      StatementBudgetItem.find_by!(budget_item_id: budget_item_id)
    else
      statement.budget_items.find_by!(budget_item: budget_item_for_transaction)
    end
  end

  def budget_item_for_transaction
    budget.items.for_transaction(statement_transaction).first
  end
end
