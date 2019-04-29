class Pokemon < ApplicationRecord
  has_and_belongs_to_many :poketypes
  has_and_belongs_to_many :evolutions, class_name: 'Pokemon',
                          join_table: :pokemons_evolutions,
                          foreign_key: :pokemon_id,
                          association_foreign_key: :evolution_id

  belongs_to :evolution_chain, optional: true
  has_one_attached :sprite
end