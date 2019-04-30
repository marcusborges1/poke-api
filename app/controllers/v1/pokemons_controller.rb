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

  def update
    @pokemon = Pokemon.find(params[:id])
    @pokemon.update(pokemon_params)
    head :no_content
  end

  private

  def pokemon_params
    params.permit(:name, :sprite)
  end
end