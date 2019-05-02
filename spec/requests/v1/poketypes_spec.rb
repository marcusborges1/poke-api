require 'rails_helper'

RSpec.describe 'Poketypes API V1' do
  let!(:poketypes)   { create_list(:poketype, 10) }

  describe 'GET /v1/types' do
    before { get '/v1/types' }

    it 'returns all poketypes' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end