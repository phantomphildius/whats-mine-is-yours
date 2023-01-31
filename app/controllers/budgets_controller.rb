class BudgetsController < ApplicationController
  def new
    @budget = Budget.new
  end

  def create
    budget_creator = BudgetCreatorService.new(title: budget_params[:title], user: current_user)
    budget_creator.create

    redirect_to budget_creator.budget
  end

  def show
    @budget = current_user.budgets.find_by!(id: params[:id])
    @new_budget_item = @budget.items.build
  end

  private

  def budget_params
    params.require(:budget).permit(:title)
  end
end
