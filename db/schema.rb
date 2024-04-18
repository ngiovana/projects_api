# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_18_023351) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "atividades", force: :cascade do |t|
    t.string "titulo"
    t.text "descricao"
    t.date "dt_inicial"
    t.date "dt_final"
    t.integer "prioridade"
    t.boolean "status"
    t.integer "id_proj"
    t.integer "id_org"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipes", force: :cascade do |t|
    t.string "nome"
    t.integer "nivel"
    t.integer "id_org"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizacaos", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participantes", force: :cascade do |t|
    t.string "email"
    t.integer "cargo"
    t.string "nome"
    t.string "senha"
    t.integer "id_eq"
    t.integer "id_org"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projetos", force: :cascade do |t|
    t.string "titulo"
    t.text "descricao"
    t.date "prazo_inicial"
    t.date "prazo_final"
    t.boolean "status"
    t.integer "nivel"
    t.integer "id_org"
    t.integer "id_eq"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "atividades", "organizacaos", column: "id_org"
  add_foreign_key "atividades", "projetos", column: "id_proj"
  add_foreign_key "equipes", "organizacaos", column: "id_org"
  add_foreign_key "participantes", "equipes", column: "id_eq"
  add_foreign_key "participantes", "organizacaos", column: "id_org"
  add_foreign_key "projetos", "equipes", column: "id_eq"
  add_foreign_key "projetos", "organizacaos", column: "id_org"
end
