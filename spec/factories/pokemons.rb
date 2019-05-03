FactoryBot.define do
  factory :pokemon do
    sequence(:name) { |number| "pokemon#{number}" }
    poketypes       { FactoryBot.create_list(:poketype, 1) }
  end
end