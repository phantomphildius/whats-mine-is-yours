class AddInstitutionReferenceToStatements < ActiveRecord::Migration[7.0]
  def change
    add_reference :statements, :institution, index: true
  end
end
