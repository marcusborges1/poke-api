require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  it { is_expected.to have_and_belong_to_many(:poketypes) }
  it { is_expected.to have_and_belong_to_many(:evolutions)
                                .class_name('Pokemon')
                                .join_table('pokemons_evolutions')
                                .with_foreign_key(:pokemon_id) }

  it { is_expected.to validate_presence_of(:name) }

  it 'is expected to has at least one poketype' do
    pokemon_without_poketypes = Pokemon.new(name: 'billy')
    expect(pokemon_without_poketypes.valid?).to be false
  end

  it 'can have no evolutions' do
    pokemon_with_no_evolutions = build(:pokemon)
    expect(pokemon_with_no_evolutions.valid?).to be true
  end

  it 'can have one or more evolutions' do
    pokemon_with_evolutions = build(:pokemon, :with_2_evolutions)
    expect(pokemon_with_evolutions.valid?).to be true
  end

  describe '.search' do
    before(:context) do
      @pikachu = create(:pokemon, name: 'pikachu')
      @raichu = create(:pokemon, name: 'raichu')
      @charmander = create(:pokemon, name: 'charmander')
    end

    context "when argument 'name' is not passed" do
      it 'returns a list of all pokemon' do
        expect(Pokemon.search.size).to eq(3)
      end
    end

    context "when argument 'name' is passed" do
      it 'returns a list of all pokemon that its names matches' do
        expect(Pokemon.search('chu')).to match_array([@pikachu, @raichu])
      end

      it 'does not returns pokemon that name does not match' do
        expect(Pokemon.search('chu')).to_not include(@charmander)
      end

      it 'returns empty array if no name matches' do
        expect(Pokemon.search('foobar')).to be_empty
      end
    end

    after(:context) do
      Pokemon.destroy_all
    end
  end
end