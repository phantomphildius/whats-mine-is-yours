class BudgetItem < ApplicationRecord
  normalize :category, with: :downcase do |value|
    value.squish
  end

  belongs_to :budget
  has_many :tags, class_name: 'BudgetItemTag', dependent: :destroy
  has_many :budget_item_transactions, dependent: :destroy
  has_many :transactions, through: :budget_item_transactions, class_name: 'StatementTransactions'

  monetize :amount_cents, numericality: { greater_than_or_equal_to: 0 }

  validates :category, uniqueness: { scope: :budget_id }

  scope :persisted, -> { where.not(id: nil) }
  scope :for_transaction, ->(transaction) do
    joins(:tags)
      .where("'#{transaction.merchant}' LIKE CONCAT('%', budget_item_tags.name, '%')")
      .or(where("'#{transaction.category}' LIKE CONCAT('%', budget_item_tags.name, '%')"))
  end

  def to_partial_path
    'budget_items/item'
  end
end
