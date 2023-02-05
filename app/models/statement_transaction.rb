class StatementTransaction < ApplicationRecord
  normalize :category, :merchant, with: :downcase do |value|
    value.squish
  end

  belongs_to :statement
  belongs_to :statement_budget_item, optional: true

  monetize :amount_cents

  validates :amount_cents, :date, :category, :merchant, presence: true

  def uncategorized?
    budget_item_transaction.nil?
  end
end
