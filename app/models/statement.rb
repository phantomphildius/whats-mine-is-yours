class Statement < ApplicationRecord
  belongs_to :budget
  belongs_to :institution

  accepts_nested_attributes_for :institution, reject_if: :all_blank

  has_many :transactions, class_name: 'StatementTransaction', dependent: :destroy

  validates :time_period, presence: true
  validates :institution, presence: true,  uniqueness: { score: :timeframe }

  delegate :name, to: :institution, prefix: true

  def total
    Money.new(transactions.sum(:amount_cents))
  end

  def met_budget?
    total < budget.total
  end
end
