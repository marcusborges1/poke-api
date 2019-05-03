require 'httparty'

namespace :fetch_from_pokeapi do
  desc 'Fetch first 78 evolution chains from pokeapi to database relating pokemon evolutions'
  task evolutions: :environment do

    1.upto(78) do |number|
      evolution_chain_url = "https://pokeapi.co/api/v2/evolution-chain/#{number}"
      response = HTTParty.get(evolution_chain_url).parsed_response
      
      # Fetches pokemon
      pokemon = Pokemon.find_by(name: response['chain']['species']['name'])
  
      # Iterates through all possible evolutions of that pokemon
      response['chain']['evolves_to'].each do |first_evolution|
        # Fetches evolution of that pokemon
        pokemon_first_evolution = Pokemon.find_by(name: first_evolution['species']['name'])
      
        # Updates pokemon evolutions
        unless (pokemon_first_evolution.nil? || pokemon.nil?)
          pokemon.evolutions << pokemon_first_evolution
          pokemon.save
          puts "#{number}/78 - Saved evolution of #{pokemon.name} to #{pokemon_first_evolution.name}."
        end
        
        # Iterate through all possible second evolutions of that pokemon
        first_evolution['evolves_to'].each do |second_evolution|
          # Fetches evolution of pokemon evolution        
          pokemon_second_evolution = Pokemon.find_by(name: second_evolution['species']['name'])
          
          # Updates pokemon evolutions
          unless (pokemon_second_evolution.nil? || pokemon_first_evolution.nil?)
            pokemon_first_evolution.evolutions << pokemon_second_evolution
            pokemon_first_evolution.save
            puts "#{number}/78 - Saved evolution of #{pokemon_first_evolution.name} to #{pokemon_second_evolution.name}."
          end
        end
      end
    end
  end
end