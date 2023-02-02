class BudgetItemEditorService
  def initialize(budget_item:, item_params:)
    @budget_item = budget_item     
    @item_category = item_params.fetch(:category)
    @amount = item_params.fetch(:amount).to_money
  end

  def update
    budget_item.transaction do # for when we tag things
      budget_item.update!(category: item_category, amount: amount)
    end
  end

  private

  attr_reader :budget_item, :amount, :item_category
end
