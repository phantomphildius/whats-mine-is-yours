class Budget < ApplicationRecord
  has_many :users, through: :budget_memberships
  has_many :items, class_name: 'BudgetItem'
  has_many :statements
end
