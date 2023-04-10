class BudgetItemInserterService
  include ActiveModel::Validations

  def initialize(budget:, budget_item_params:)
    @budget = budget
    @budget_item_params = budget_item_params
  end

  validate :budget_item_params_are_present

  def insert
    if valid? && budget_item.valid?
      budget_item.with_lock do
        budget_item.save!
        StatementBudgetItemBackfillJob.perform_later(
          budget: budget,
          budget_item: budget_item
        )
      end
      true
    else
      delegate_budget_item_errors if budget_item.invalid?
      false
    end
  end

  def budget_item
    @budget_item ||= budget.items.new(budget_item_params)
  end

  private

  attr_reader :budget, :budget_item_params

  def budget_item_params_are_present
    unless budget_item_params.values.compact.length == 2
      errors.add(:base, "missing parameters")
    end
  end

  def delegate_budget_item_errors
    budget_item.errors.to_hash.each { |key, value| errors.add(key, value) }
  end
end
