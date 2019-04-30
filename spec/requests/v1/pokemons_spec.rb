require 'rails_helper'

RSpec.describe 'Pokemons API V1', type: :request do

  let!(:pokemons)   { create_list(:pokemon, 10) }
  let(:pokemon_id)  { pokemons.first.id }

  describe 'GET /v1/pokemon' do
    context "when a query string with param 'name' does not exist" do
      before { get '/v1/pokemon' }

      it 'returns all pokemon' do
        expect(JSON.parse(response.body).size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context "when a query string with param 'name' exists" do
      before(:context) do
        create(:pokemon, name: 'pikachu')
        create(:pokemon, name: 'raichu')
      end

      it 'returns all pokemon that name matches' do
        get '/v1/pokemon?name=chu'
        expect(JSON.parse(response.body).size).to eq(2)
      end

      it 'returns empty array if no pokemon name matches' do
        get '/v1/pokemon?name=billy'
        expect(JSON.parse(response.body)).to be_empty
      end

      it 'returns status code 200' do
        get '/v1/pokemon?name=billy'
        expect(response).to have_http_status(200)
      end
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

  describe 'POST /v1/pokemon' do
    context 'when the request is valid' do
      let(:valid_attributes) { { name: 'billy' } }

      before { post '/v1/pokemon', params: valid_attributes }

      it 'creates a pokemon' do
        expect(JSON.parse(response.body)['name']).to eq('billy')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/v1/pokemon', params: { } }

      it 'returns a status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /v1/pokemon/:id' do
    let(:valid_attributes) { { name: 'billy' } }

    context 'when the record exists' do
      before { put "/v1/pokemon/#{pokemon_id}", params: valid_attributes }

      it 'returns an empty body' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the record' do
        get "/v1/pokemon/#{pokemon_id}"
        expect(JSON.parse(response.body)['name']).to eq('billy')
      end
    end

    context 'when the record does not exist' do
      let(:unexistent_id) { 500 }

      before { put "/v1/pokemon/#{unexistent_id}", params: valid_attributes }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Couldn't find Pokemon/)
      end
    end
  end

  describe 'DELETE /v1/pokemon/:id' do
    before { delete "/v1/pokemon/#{pokemon_id}" }

    it 'returns an empty body' do
      expect(response.body).to be_empty
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'deletes the record' do
      get "/v1/pokemon/#{pokemon_id}"
      expect(response.body)
          .to match(/Couldn't find Pokemon/)
    end
  end
end