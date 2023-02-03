class RemoveInstitutionFromStatements < ActiveRecord::Migration[7.0]
  def change
    remove_column :statements, :institution
  end
end
