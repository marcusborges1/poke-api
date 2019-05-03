FactoryBot.define do
  factory :pokemon do
    sequence(:name) { |number| "pokemon#{number}" }
    poketypes       { FactoryBot.create_list(:poketype, 1) }
  
    trait :with_2_evolutions do
      evolutions    { FactoryBot.create_list(:pokemon, 2) }
    end
  end
end