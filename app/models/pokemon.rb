class Pokemon < ApplicationRecord
  has_and_belongs_to_many :poketypes
  has_and_belongs_to_many :evolutions, class_name: 'Pokemon',
                          join_table: :pokemons_evolutions,
                          foreign_key: :pokemon_id,
                          association_foreign_key: :evolution_id
  has_one_attached :sprite

  validates :name, presence: true

  def self.search(name = nil)
    return Pokemon.where('name LIKE ?', "%#{name}%") if name.present?
    Pokemon.all
  end
end