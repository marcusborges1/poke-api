class CreateJoinTablePokemonPoketype < ActiveRecord::Migration[5.2]
  def change
    create_join_table :pokemons, :poketypes do |t|
      t.index [:pokemon_id, :poketype_id]
      t.index [:poketype_id, :pokemon_id]
    end
  end
end
