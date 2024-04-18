class CreateAtividades < ActiveRecord::Migration[7.1]
  def change
    create_table :atividades do |t|
      t.string :titulo
      t.text :descricao
      t.date :dt_inicial
      t.date :dt_final
      t.integer :prioridade
      t.boolean :status
      # t.integer :id_proj

      t.timestamps
    end
  end
end
