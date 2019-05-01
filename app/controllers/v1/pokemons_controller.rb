class V1::PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :update, :destroy]

  def index
    @pokemons = Pokemon.search(params[:name])
    render json: @pokemons, status: :ok
  end

  def show
    render json: @pokemon, status: :ok
  end

  def create
    @pokemon = Pokemon.create!(pokemon_params)
    render json: @pokemon, status: :created
  end

  def update
    @pokemon.update(pokemon_params)
    head :no_content
  end

  def destroy
    @pokemon.destroy
    head :no_content
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])    
  end

  def pokemon_params
    params.permit(:name, :sprite)
  end
end