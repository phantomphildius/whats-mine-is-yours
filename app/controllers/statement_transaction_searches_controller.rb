class StatementTransactionSearchesController < ApplicationController
  def index
    @monthly_statement = monthly_statement
    @statement_search =
      StatementTransactionSearcherService.new(
        @monthly_statement,
        statement_transaction_params
      )
    @statement_search.execute
  end

  private

  def statement_transaction_params
    StatementTransactionSearch::Params.new(params.except(:monthly_statement_id))
  end

  def monthly_statement
    current_user.monthly_statements.find_sole_by(
      id: params.fetch(:monthly_statement_id)
    )
  end
end
