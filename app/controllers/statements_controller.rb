class StatementsController < ApplicationController
  def index
    @current_budget = current_user.budgets.last
  end
end
