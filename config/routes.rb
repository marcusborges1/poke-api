Rails.application.routes.draw do
  namespace :v1 do
    resources :pokemon, controller: 'pokemons'
    get '/types', to: 'poketypes#index'
  end
end
