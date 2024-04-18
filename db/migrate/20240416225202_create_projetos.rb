class CreateProjetos < ActiveRecord::Migration[7.1]
  def change
    create_table :projetos do |t|
      t.string :titulo
      t.text :descricao
      t.date :prazo_inicial
      t.date :prazo_final
      t.boolean :status
      t.integer :nivel
      t.integer :id_org
      t.integer :id_eq
      # t.integer :id_ativ

      t.timestamps
    end
  end
end
