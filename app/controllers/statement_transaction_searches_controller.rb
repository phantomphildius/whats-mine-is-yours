class StatementTransactionSearchesController < ApplicationController
  def create
    @statement_search = StatementTransactionSearcherService.new(monthly_statement, statement_transaction_params)
    @statement_search.execute
  end

  private

  def statement_transaction_params
    StatementTransactionSearch::Params.new(statement_transaction_search_params.except(:monthly_statement_id))
  end

  def monthly_statement
    current_user.monthly_statements.find_sole_by(
      id: statement_transaction_search_params.fetch(:monthly_statement_id)
    )
  end

  def statement_transaction_search_params
    params.require(:statement_transaction_search).permit(:monthly_statement_id)
  end
end
