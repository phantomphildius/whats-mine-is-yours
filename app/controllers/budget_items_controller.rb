class BudgetItemsController < ApplicationController
  def create
    @budget = current_user.budgets.find_sole_by(id: params.fetch(:budget_id))    
    @budget_item = @budget.items.new(budget_item_params)
    # TODO: create statement budget items for old statements
    if @budget_item.save
      @new_budget_item = @budget.items.new
    else
      flash[:error] = "could not create budget #{@budget.errors}"
      redirect_to @budget
    end
  end

  def edit
    budget = current_user.budgets.find_sole_by(id: params.fetch(:budget_id))    
    @budget_item = budget.items.find_sole_by(id: params.fetch(:id))
  end

  def update
    @budget = current_user.budgets.find_sole_by(id: params.fetch(:budget_id))    
    @item_for_update = @budget.items.find_sole_by(id: params.fetch(:id))

    unless @item_for_update.update(budget_item_params)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @budget = current_user.budgets.find_sole_by(id: params.fetch(:budget_id))    
    @budget_item = @budget.items.find_sole_by(id: params.fetch(:id))
    @budget_item.destroy!
  end

  private

  def budget_item_params
    params.require(:budget_item).permit(:category, :amount).tap do |item|
      item[:amount] = item[:amount].to_money
    end
  end
end
