require 'httparty'

namespace :fetch_from_pokeapi do
  desc 'Fetch first 78 evolution chains from pokeapi to database relating pokemon evolutions'
  task evolutions: :environment do
    abort 'This task can only be used with empty evolution_chains table.' if EvolutionChain.count > 0

    1.upto(78) do |number|
      evolution_chain_url = "https://pokeapi.co/api/v2/evolution-chain/#{number}"
      response = HTTParty.get(evolution_chain_url).parsed_response
      
      # Creates evolution_chain
      evolution_chain = EvolutionChain.create
  
      # Saves pokemon in current evolution chain
      pokemon = Pokemon.find_by(name: response['chain']['species']['name'])
      unless pokemon.nil?
        pokemon.evolution_chain = evolution_chain
        pokemon.save
        puts "#{number}/78 - Saved #{pokemon.name} in evolution chain (id #{evolution_chain.id})."
      end
  
      # Iterate through all possible evolutions of that pokemon
      response['chain']['evolves_to'].each do |first_evolution|
        # Updates pokemon first evolution order to 2 and saves its current evolution chain
        pokemon_first_evolution = Pokemon.find_by(name: first_evolution['species']['name'])
        unless pokemon_first_evolution.nil?
          pokemon_first_evolution.evolution_order = 2
          pokemon_first_evolution.evolution_chain = evolution_chain
          pokemon_first_evolution.save
          puts "#{number}/78 - Saved #{pokemon_first_evolution.name} in evolution chain (id #{evolution_chain.id})."
      
          # Updates pokemon evolutions
          unless pokemon.nil?
            pokemon.evolutions << pokemon_first_evolution
            pokemon.save
            puts "#{number}/78 - Saved evolution of #{pokemon.name} to #{pokemon_first_evolution.name}."
          end
        end
  
        # Iterate through all possible second evolutions of that pokemon
        first_evolution['evolves_to'].each do |second_evolution|
          # Updates pokemon second evolution order to 3 and saves its current evolution chain        
          pokemon_second_evolution = Pokemon.find_by(name: second_evolution['species']['name'])
          
          unless pokemon_second_evolution.nil?
            pokemon_second_evolution.evolution_order = 3
            pokemon_second_evolution.evolution_chain = evolution_chain
            pokemon_second_evolution.save
            puts "#{number}/78 - Saved #{pokemon_second_evolution.name} in evolution chain (id #{evolution_chain.id})."
            
            # Updates pokemon evolutions
            unless pokemon_first_evolution.nil?
              pokemon_first_evolution.evolutions << pokemon_second_evolution
              pokemon_first_evolution.save
              puts "#{number}/78 - Saved evolution of #{pokemon_first_evolution.name} to #{pokemon_second_evolution.name}."
            end
          end
        end
      end
    end
  end
end