class BudgetItemUpserterService
  attr_reader :budget_item
  
  def initialize(budget:, item_params:)
    @budget = budget     
    @item_category = item_params.fetch(:category)
    @amount = item_params.fetch(:amount).to_money
  end

  def upsert!
    budget.transaction do # for when we tag things
      @budget_item = budget.items.find_or_initialize_by(category: item_category)
      budget_item.update!(amount: amount)
    end
  end

  private

  attr_reader :budget, :amount, :item_category
end
