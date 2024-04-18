class AddOrgIdAndEqIdToProjetos < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :projetos, :organizacaos, column: :id_org
    add_foreign_key :projetos, :equipes, column: :id_eq
  end
end
