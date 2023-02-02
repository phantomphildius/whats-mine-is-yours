class BudgetItemsController < ApplicationController
  def create
    @budget = current_user.budgets.find_sole_by(id: params.fetch(:budget_id))    
    item_creator = BudgetItemUpserterService.new(budget: @budget, item_params: create_params)
  
    item_creator.upsert!

    redirect_to @budget
  end

  def destroy
    budget = current_user.budgets.find_sole_by(id: params.fetch(:budget_id))    

    budget.items.find_sole_by(id: params.fetch(:id)).destroy!

    redirect_to budget
  end

  private

  def create_params
    params.require(:budget_item).permit(:category, :amount)
  end
end