module MonthlyStatementHelper
  def statement_budget_item_categories_for(monthly_statement)
    monthly_statement.budget.items.order('budget_items.category ASC').pluck( 'budget_items.category', 'budget_items.id')
  end
end
