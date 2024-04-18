class AddProjIdToAtividades < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :atividades, :projetos, column: :id_proj
    add_foreign_key :atividades, :organizacaos, column: :id_org
  end
end
