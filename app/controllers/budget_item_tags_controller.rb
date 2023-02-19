class BudgetItemTagsController < ApplicationController
  def new
    @budget = current_user.budgets.find_sole_by(id: params.fetch(:budget_id))
    @budget_item = @budget.items.find_sole_by(id: params.fetch(:item_id))
    @tag = @budget_item.tags.new
  end

  def create
    budget = current_user.budgets.find_sole_by(id: params.fetch(:budget_id))
    @budget_item = budget.items.find_sole_by(id: params.fetch(:item_id))
    @tag = @budget_item.tags.create(tag_params)
    @new_tag = @budget_item.tags.new
  end

  private

  def tag_params
    params.require(:budget_item_tag).permit(:name)
  end
end
