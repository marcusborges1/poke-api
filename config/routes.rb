Rails.application.routes.draw do
  namespace :v1 do
    get '/pokemon', to: 'pokemons#index'
  end
end
