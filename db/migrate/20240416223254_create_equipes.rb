class CreateEquipes < ActiveRecord::Migration[7.1]
  def change
    create_table :equipes do |t|
      t.string :nome
      t.integer :nivel
      # t.integer :id_org
      # t.integer :id_part
      # t.integer :id_proj

      t.timestamps
    end
  end
end
