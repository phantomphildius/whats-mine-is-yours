class BudgetItemTag < ApplicationRecord
  normalize_attr :name, with: :downcase do |value|
    value.squish
  end

  belongs_to :budget_item
  
  # TODO: make this custom per budget
  #
  validates :name, uniqueness: true 

  def to_partial_path
    'budget_item_tags/tag'
  end
end
