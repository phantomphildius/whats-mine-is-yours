class MonthlyStatementChartsController < ApplicationController
  def show
    presenter =
      MonthlyStatementChartsPresenter.new(monthly_statement, params[:id])
    render json: presenter.build_chart, status: :ok
  end

  private

  def monthly_statement
    monthly_statement_id = params.fetch(:monthly_statement_id)
    current_user.current_budget.monthly_statements.find_by(
      id: monthly_statement_id
    )
  end
end
