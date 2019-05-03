class Pokemon < ApplicationRecord
  has_and_belongs_to_many :poketypes
  has_and_belongs_to_many :evolutions, class_name: 'Pokemon',
                          join_table: :pokemons_evolutions,
                          foreign_key: :pokemon_id,
                          association_foreign_key: :evolution_id
  has_one_attached :sprite

  validates :name, presence: true
  validate :poketypes_cannot_be_empty

  alias_attribute :type_ids, :poketype_ids

  def self.search(name = nil)
    return Pokemon.where('name LIKE ?', "%#{name}%") if name.present?
    Pokemon.all
  end

  private

  def poketypes_cannot_be_empty
    errors.add(:types, "can't be empty") unless poketypes.present?
  end
end