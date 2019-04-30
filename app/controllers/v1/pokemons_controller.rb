class V1::PokemonsController < ApplicationController
  def index
    if params[:name].present?
      @pokemons = Pokemon.where('name LIKE ?', "%#{params[:name]}%")
    elsif
      @pokemons = Pokemon.all
    end
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

  def destroy
    @pokemon = Pokemon.find(params[:id])
    @pokemon.destroy
    head :no_content
  end

  private

  def pokemon_params
    params.permit(:name, :sprite)
  end
end