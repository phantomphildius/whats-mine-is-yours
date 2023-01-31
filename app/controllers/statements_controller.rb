class StatementsController < ApplicationController
  before_action :ensure_budget

  def index
    @current_budget = current_user.budgets.last
  end

  private

  def ensure_budget
    redirect_to new_budget_path unless current_user.budgets.any?
  end
end
