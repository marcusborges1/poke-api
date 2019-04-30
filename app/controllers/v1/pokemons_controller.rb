class V1::PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
    render json: @pokemons, status: :ok
  end
end