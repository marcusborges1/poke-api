require 'httparty'

namespace :fetch_from_pokeapi do
  desc 'Fetch first 151 pokemon from pokeapi to database'
  task pokemons: :environment do
    abort 'This task can only be used with empty pokemons table.' if Pokemon.count > 0

    temp_sprite_path = Rails.root.join('tmp', 'pokemon.png')

    1.upto(151) do |number|
      pokemon_url = "https://pokeapi.co/api/v2/pokemon/#{number}"
      response = HTTParty.get(pokemon_url).parsed_response

      poketypes = []
      response['types'].each do |type_hash|
        poketypes << Poketype.find_by(name: type_hash['type']['name'])
      end

      File.open(temp_sprite_path, 'wb') do |file|
        HTTParty.get(response['sprites']['front_default']) { |fragment| file.write(fragment) }
      end

      pokemon = Pokemon.create(name: response['name'], poketypes: poketypes)
      pokemon.sprite.attach(io: File.open(temp_sprite_path), filename: "#{pokemon.name}.png",
        content_type: 'image/png')

      puts "#{number}/151 - Pokemon #{response['name']} saved (id #{response['id']})."
    end
  end
end