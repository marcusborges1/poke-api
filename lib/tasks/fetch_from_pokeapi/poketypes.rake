require 'httparty'

namespace :fetch_from_pokeapi do
  desc 'Fetch all 18 pokemon types from pokeapi to database'
  task poketypes: :environment do
    abort 'This task can only be used with empty poketypes table.' if Poketype.count > 0

    1.upto(18) do |number|
      pokemon_type_url = "https://pokeapi.co/api/v2/type/#{number}"
      response = HTTParty.get(pokemon_type_url).parsed_response
    
      Poketype.create(name: response['name'])
      puts "#{number}/18 - Saving type #{response['name']} (id #{response['id']})."
    end
  end
end