Rails.application.routes.draw do
  namespace :v1 do
    resources :pokemon, controller: 'pokemons'
  end
end
