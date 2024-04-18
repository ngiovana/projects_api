class AddIdEqToAtividades < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :atividades, :equipes, column: :id_eq
  end
end
