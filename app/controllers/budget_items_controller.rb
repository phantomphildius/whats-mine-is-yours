class BudgetItemsController < ApplicationController
  def create
    budget = current_user.budgets.find_by(id: params.fetch(:budget_id))    
    item_creator = BudgetItemCreatorService.new(budget: budget, item_params: create_params)
  
    item_creator.create

    redirect_to budget
  end

  private

  def create_params
    params.require(:budget_item).permit(:category, :amount)
  end
end