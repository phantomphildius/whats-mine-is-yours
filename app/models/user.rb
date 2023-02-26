class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :timeoutable, :validatable

  has_many :budget_memberships
  has_many :budgets, through: :budget_memberships
  has_many :monthly_statements, through: :budgets

  def current_budget
    budgets.last
  end
end
