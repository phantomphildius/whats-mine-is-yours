class TransactionCategorizationsController < ApplicationController
  def create
    @monthly_statement = monthly_statement
    transaction_categorizer = TransactionCategorizerService.new(
      statement_transaction: transaction,
      budget: current_user.current_budget,
      statement: transaction.statement,
      budget_item_id: transaction_categorization_params.fetch(:budget_item_id),
    )

    transaction_categorizer.categorize
  end

  private

  def transaction_categorization_params
    params.require(:transaction_categorization).permit(:budget_item_id, :transaction_id)
  end

  def transaction
    @transaction ||= monthly_statement.transactions.find_sole_by(id: transaction_categorization_params.fetch(:transaction_id))
  end

  def monthly_statement
    current_user.monthly_statements.find_sole_by(id: params.fetch(:monthly_statement_id))
  end
end
