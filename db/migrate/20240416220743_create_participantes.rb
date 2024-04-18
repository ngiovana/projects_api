class CreateParticipantes < ActiveRecord::Migration[7.1]
  def change
    create_table :participantes do |t|
      t.string :email
      t.integer :cargo
      t.string :nome
      t.string :senha
      t.integer :id_eq
      t.integer :id_org

      t.timestamps
    end
    # add_index :participantes, :email, unique: true
  end
end
