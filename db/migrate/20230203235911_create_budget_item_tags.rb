class CreateBudgetItemTags < ActiveRecord::Migration[7.0]
  def change
    create_table :budget_item_tags do |t|
      t.references :budget_item, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
