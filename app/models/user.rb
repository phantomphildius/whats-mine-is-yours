class User < ApplicationRecord
  devise :confirmable, :database_authenticatable, :recoverable, :registerable,
         :rememberable, :timeoutable, :validatable

  has_many :budgets, through: :budget_memberships
end
