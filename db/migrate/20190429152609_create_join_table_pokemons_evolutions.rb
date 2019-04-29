class CreateJoinTablePokemonsEvolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons_evolutions, id: false do |t|
      t.integer :pokemon_id, null: false
      t.integer :evolution_id, null: false
    end

    add_index(:pokemons_evolutions, [:pokemon_id, :evolution_id], unique: true)
    add_index(:pokemons_evolutions, [:evolution_id, :pokemon_id], unique: true)
  end
end
