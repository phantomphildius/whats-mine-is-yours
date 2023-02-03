class BudgetItem < ApplicationRecord
  normalize :category, with: :downcase do |value|
    value.squish
  end

  belongs_to :budget

  monetize :amount_cents, numericality: { greater_than_or_equal_to: 0 }

  validates :category, uniqueness: { scope: :budget_id }

  scope :persisted, -> { where.not(id: nil) }

  def to_partial_path
    'budget_items/item'
  end
end
