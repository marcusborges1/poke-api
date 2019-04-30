class V1::PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
    render json: @pokemons, status: :ok
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    render json: @pokemon, status: :ok
  end

  def create
    @pokemon = Pokemon.create!(pokemon_params)
    render json: @pokemon, status: :created
  end

  private

  def pokemon_params
    params.permit(:name, :sprite)
  end
end