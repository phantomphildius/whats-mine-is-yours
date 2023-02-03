class Statement < ApplicationRecord
  belongs_to :budget

  has_many :transactions, class_name: 'StatementTransaction'

  validates :time_period, presence: true
  validates :institution, presence: true,  uniqueness: { score: :timeframe }

  def total
    Money.new(transactions.sum(:amount_cents))
  end

  def met_budget?
    total < budget.total
  end
end
