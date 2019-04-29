# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_29_174220) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "evolution_chains", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "evolution_chain_id"
    t.integer "evolution_order", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evolution_chain_id"], name: "index_pokemons_on_evolution_chain_id"
    t.index ["name"], name: "index_pokemons_on_name", unique: true
  end

  create_table "pokemons_evolutions", id: false, force: :cascade do |t|
    t.integer "pokemon_id", null: false
    t.integer "evolution_id", null: false
    t.index ["evolution_id", "pokemon_id"], name: "index_pokemons_evolutions_on_evolution_id_and_pokemon_id", unique: true
    t.index ["pokemon_id", "evolution_id"], name: "index_pokemons_evolutions_on_pokemon_id_and_evolution_id", unique: true
  end

  create_table "pokemons_poketypes", id: false, force: :cascade do |t|
    t.bigint "pokemon_id", null: false
    t.bigint "poketype_id", null: false
    t.index ["pokemon_id", "poketype_id"], name: "index_pokemons_poketypes_on_pokemon_id_and_poketype_id"
    t.index ["poketype_id", "pokemon_id"], name: "index_pokemons_poketypes_on_poketype_id_and_pokemon_id"
  end

  create_table "poketypes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_poketypes_on_name", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "pokemons", "evolution_chains"
end
