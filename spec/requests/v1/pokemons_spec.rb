require 'rails_helper'

RSpec.describe 'Pokemons API V1', type: :request do

  let!(:pokemons)   { create_list(:pokemon, 10) }
  let(:pokemon_id)  { pokemons.first.id }

  describe 'GET /v1/pokemon' do
    before { get '/v1/pokemon' }

    it 'returns all pokemon' do
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /v1/pokemon/:id' do
    before { get "/v1/pokemon/#{pokemon_id}" }

    context 'when the record exists' do
      it 'returns the pokemon' do
        expect(JSON.parse(response.body)['id']).to eq(pokemon_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:pokemon_id) { 500 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Pokemon/)
      end
    end
  end
end