class AddOrgIdAndParIdAndProjIdToEquipes < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :equipes, :organizacaos, column: :id_org
  end
end
