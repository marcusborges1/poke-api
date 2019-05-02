FactoryBot.define do
  factory :poketype do
    sequence(:name) { |number| "type#{number}" }
  end
end