class Budget < ApplicationRecord
  has_many :users, through: :budget_memberships
  has_many :items, class_name: 'BudgetItem'
  has_many :monthly_statements

  def total
    Money.new(items.sum(:amount_cents))
  end
end
