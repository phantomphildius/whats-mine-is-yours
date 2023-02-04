class BudgetItemTag < ApplicationRecord
  normalize_attr :name, with: :downcase do |value|
    value.squish
  end

  belongs_to :budget_item
  
  validates :name, uniqueness: true 
end
