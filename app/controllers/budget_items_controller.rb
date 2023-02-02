class BudgetItemsController < ApplicationController
  def create
    @budget = current_user.budgets.find_sole_by(id: params.fetch(:budget_id))    
    item_creator = BudgetItemUpserterService.new(budget: @budget, item_params: budget_item_params)
  
    item_creator.upsert!

    @budget_item = item_creator.budget_item
    @new_budget_item = @budget.items.new
  end

  def edit
    budget = current_user.budgets.find_sole_by(id: params.fetch(:budget_id))    
    @budget_item = budget.items.find_sole_by(id: params.fetch(:id))
  end

  def update
    @budget = current_user.budgets.find_sole_by(id: params.fetch(:budget_id))    
    @item_for_update = @budget.items.find_sole_by(id: params.fetch(:id))

    item_editor = BudgetItemEditorService.new(
      budget_item: @item_for_update, 
      item_params: budget_item_params,
    )
  
    item_editor.update
  end

  def destroy
    budget = current_user.budgets.find_sole_by(id: params.fetch(:budget_id))    

    budget.items.find_sole_by(id: params.fetch(:id)).destroy!

    redirect_to budget
  end

  private

  def budget_item_params
    params.require(:budget_item).permit(:category, :amount)
  end
end