class BudgetItem < ApplicationRecord
  normalize :category, with: :downcase do |value|
    value.squish
  end

  belongs_to :budget

  monetize :amount_cents

  validates :category, uniqueness: { scope: :budget_id }

  scope :persisted, -> { where.not(id: nil) }

  def to_partial_path
    'budget_items/item'
  end
end
