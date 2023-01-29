class CreateStatements < ActiveRecord::Migration[7.0]
  def change
    create_table :statements do |t|
      t.references :budget, null: false, foreign_key: true
      t.date :time_period
      t.string :institution

      t.timestamps
    end
    add_index :statements, :time_period
    add_index :statements, :institution
  end
end
