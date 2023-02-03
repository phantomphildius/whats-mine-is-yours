class StatementTransaction < ApplicationRecord
  normalize :category, :merchant, with: :downcase do |value|
    value.squish
  end

  belongs_to :statement

  monetize :amount_cents

  validates :amount_cents, :date, :category, :merchant, presence: true
end
