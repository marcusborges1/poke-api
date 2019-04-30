FactoryBot.define do
  factory :pokemon do
    name { Faker::Games::Pokemon.unique.name }
  end
end