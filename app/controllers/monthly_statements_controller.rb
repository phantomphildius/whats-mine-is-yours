class MonthlyStatementsController < ApplicationController
  def show
    @monthly_statement = current_user.current_budget.monthly_statements.find_sole_by(id: params.fetch(:id))
  end
end
