class ChangeNullConstraintForMonthlyStatementForeignKey < ActiveRecord::Migration[7.0]
  def change
    Statement.find_each do |s|
      b = Budget.last
      ms = MonthlyStatement.create_with(budget_id: b.id).find_or_create_by!(time_period: s.time_period)
      s.update(monthly_statement_id: ms.id)
    end
    change_column_null :statements, :monthly_statement_id, false
  end
end
