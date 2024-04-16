class CreateOrganizacaos < ActiveRecord::Migration[7.1]
  def change
    create_table :organizacaos do |t|
      t.string :nome
      t.text :descricao

      t.timestamps
    end
  end
end
