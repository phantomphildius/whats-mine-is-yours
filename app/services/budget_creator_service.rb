class BudgetCreatorService
  include ActiveRecord::Validations
  
  def initialize(user:, title:)
    @user = user
    @title = title
  end

  def create
    ActiveRecord::Base.transaction do
      budget.save!  
      budget_membership.update!(budget: budget)
    end
  end

  def budget
    @budget ||= Budget.new(title: title)
  end

  private

  attr_reader :user, :title

  def budget_membership
    BudgetMembership.new(user: user)
  end
end
