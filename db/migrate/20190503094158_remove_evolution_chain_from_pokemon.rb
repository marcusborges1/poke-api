class RemoveEvolutionChainFromPokemon < ActiveRecord::Migration[5.2]
  def change
    remove_reference :pokemons, :evolution_chain, foreign_key: true
  end
end
