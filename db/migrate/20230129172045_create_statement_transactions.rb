class CreateStatementTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :statement_transactions do |t|
      t.references :statement, null: false, foreign_key: true
      t.date :date
      t.integer :amount_cents
      t.string :merchant
      t.string :category

      t.timestamps
    end
    add_index :statement_transactions, :date
    add_index :statement_transactions, :merchant
    add_index :statement_transactions, :category
  end
end
