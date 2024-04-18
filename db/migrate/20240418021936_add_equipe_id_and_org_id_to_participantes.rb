class AddEquipeIdAndOrgIdToParticipantes < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :participantes, :equipes, column: :id_eq
    add_foreign_key :participantes, :organizacaos, column: :id_org
  end
end
