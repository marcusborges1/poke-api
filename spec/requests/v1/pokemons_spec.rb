require 'rails_helper'

RSpec.describe 'Pokemons API V1', type: :request do

  let!(:pokemons) { create_list(:pokemon, 10) }

  describe 'GET /v1/pokemon' do
    before { get '/v1/pokemon' }

    it 'returns all pokemon' do
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end