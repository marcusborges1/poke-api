require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  it { is_expected.to have_and_belong_to_many(:poketypes) }
  it { is_expected.to have_and_belong_to_many(:evolutions)
                                .class_name('Pokemon')
                                .join_table('pokemons_evolutions')
                                .with_foreign_key(:pokemon_id) }

  it { is_expected.to belong_to(:evolution_chain).optional }
end