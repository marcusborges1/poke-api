FactoryBot.define do
  factory :pokemon do
    sequence(:name) { |number| "pokemon#{number}" }
  end
end