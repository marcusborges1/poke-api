class V1::PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
    render json: @pokemons, status: :ok
  end

  def show
    begin
      @pokemon = Pokemon.find(params[:id])
      render json: @pokemon, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: e.message, status: :not_found
    end
  end
end