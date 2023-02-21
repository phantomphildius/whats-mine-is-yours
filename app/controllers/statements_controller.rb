class StatementsController < ApplicationController
  def index
    @current_budget = current_budget
    @monthly_statements = @current_budget.monthly_statements.map { |ms| MonthlyStatementPresenter.new(ms) }
  end

  def new
    @statement = Statement.new
  end

  def create
    importer = StatementImporterService.new(
      budget: current_budget,
      institution_name: create_params.fetch(:institution),
      time_period: create_params.fetch(:time_period),
      statement_file: create_params.fetch(:statement_file),
    )

    importer.import

    @monthly_statement = importer.monthly_statement
  end

  private

  def create_params
    @create_params ||= params.require(:statement).permit(:time_period, :institution, :statement_file)
  end

  def current_budget
    current_user.budgets.last
  end
end
