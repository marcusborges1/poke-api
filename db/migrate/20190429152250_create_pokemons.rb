class CreatePokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons do |t|
      t.string :name, null: false, index: { unique: true }
      t.references :evolution_chain, foreign_key: true
      t.integer :evolution_order, null: false, default: 1
      t.timestamps
    end
  end
end
