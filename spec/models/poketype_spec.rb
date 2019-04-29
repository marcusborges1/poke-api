require 'rails_helper'

RSpec.describe Poketype, type: :model do
  it { is_expected.to have_and_belong_to_many(:pokemons) }
end