require 'rails_helper'

RSpec.describe EvolutionChain, type: :model do
  it { is_expected.to have_many(:pokemons) }
end