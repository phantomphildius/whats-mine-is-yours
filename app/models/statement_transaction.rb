class StatementTransaction < ApplicationRecord
  normalize :category, :merchant, with: :downcase do |value|
    value.squish
  end

  belongs_to :statement
  belongs_to :statement_budget_item, optional: true

  scope :uncategorized, -> { where(statement_budget_item_id: nil) }

  monetize :amount_cents

  validates :amount_cents, :date, :category, :merchant, presence: true

  delegate :institution_name, to: :statement
  delegate :budget_item_category, to: :statement_budget_item, allow_nil: true

  def to_partial_path
    "monthly_statements/transaction"
  end

  def uncategorized?
    statement_budget_item.nil?
  end
end
