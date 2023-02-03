class StatementsController < ApplicationController
  def index
    @current_budget = current_budget
    @statements = @current_budget.statements
  end

  def new
    @statement = Statement.new
  end

  def create
    importer = StatementImporterService.new(
      budget: current_budget,
      institution: create_params.fetch(:institution),
      time_period: create_params.fetch(:time_period),
      statement_file: create_params.fetch(:statement_file),
    )

    importer.import

    redirect_to statements_path
  end

  private

  def create_params
    @create_params ||= params.require(:statement).permit(:time_period, :institution, :statement_file)
  end

  def current_budget
    current_user.budgets.last
  end
end
