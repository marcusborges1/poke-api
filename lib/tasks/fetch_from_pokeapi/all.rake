namespace :fetch_from_pokeapi do
  desc 'Fetch all pokemon types, first 151 pokemon and its evolutions from pokeapi'
  task all: :environment do
    Rake::Task['fetch_from_pokeapi:poketypes'].invoke
    Rake::Task['fetch_from_pokeapi:pokemons'].invoke
    Rake::Task['fetch_from_pokeapi:evolutions'].invoke
  end
end