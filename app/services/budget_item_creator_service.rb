class BudgetItemCreatorService
  def initialize(budget:, item_params:)
    @budget = budget     
    @item_category = item_params.fetch(:category)
    @amount = item_params.fetch(:amount).to_money
  end

  def create
    budget.transaction do # for when we tag things
      budget.items.create!(
        category: item_category,
        amount: amount,
      )
    end
  end

  private

  attr_reader :budget, :amount, :item_category
end
