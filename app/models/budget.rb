class Budget < ApplicationRecord
  has_many :users, through: :budget_memberships
  has_many :items, class_name: 'BudgetItem'
  has_many :statements

  def total
    items.sum(:amount_cents) / 100
  end
end
