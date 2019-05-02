class V1::PoketypesController < ApplicationController
  def index
    @poketypes = Poketype.all
    render json: @poketypes, status: :ok
  end
end