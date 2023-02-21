class Statement < ApplicationRecord
  belongs_to :monthly_statement
  belongs_to :institution

  has_many :budget_items, class_name: 'StatementBudgetItem', dependent: :destroy

  accepts_nested_attributes_for :institution, reject_if: :all_blank

  has_many :transactions, class_name: 'StatementTransaction', dependent: :destroy

  validates :time_period, presence: true
  validates :institution, presence: true,  uniqueness: { scope: :time_period }

  delegate :name, to: :institution, prefix: true

  def total
    Money.new(transactions.sum(:amount_cents))
  end
end
