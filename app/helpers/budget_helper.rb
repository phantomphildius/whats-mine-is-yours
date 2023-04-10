module BudgetHelper
  def budget_to_chart(budget)
    budget
      .items
      .pluck(:category, :amount_cents)
      .each_with_object({}) do |tuple, obj|
        category, amount = tuple
        obj[category] = amount / 100
      end
  end
end
