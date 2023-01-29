class CreateBudgetMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :budget_memberships do |t|
      t.references :budget, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamp :revoked_at

      t.timestamps
    end
    add_index :budget_memberships, :revoked_at
  end
end
