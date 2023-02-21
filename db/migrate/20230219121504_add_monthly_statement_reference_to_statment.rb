class AddMonthlyStatementReferenceToStatment < ActiveRecord::Migration[7.0]
  def change
    add_reference :statements, :monthly_statement, foreign_key: true, null: true
  end
end
