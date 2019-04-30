class V1::PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
    render json: @pokemons, status: :ok
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    render json: @pokemon, status: :ok
  end
end