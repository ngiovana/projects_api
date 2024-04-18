class AddProjIdToAtividades < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :atividades, :projetos, column: :id_proj
  end
end
