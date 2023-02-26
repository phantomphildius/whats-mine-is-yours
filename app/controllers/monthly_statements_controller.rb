class MonthlyStatementsController < ApplicationController
  def show
    @monthly_statement = current_user.current_budget.monthly_statements.find_sole_by(id: params.fetch(:id))
    @institutions = @monthly_statement.statements.joins(:institution).order('institutions.name').pluck('institutions.name')
    @categories = @monthly_statement.budget.items.pluck(:category)
  end
end
