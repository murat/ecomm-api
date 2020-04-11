# frozen_string_literal: true
FactoryBot.define do
  factory :specification do
    product
    sequence(:position) { n }
    spec_key { Faker::Lorem.word }
    spec_val { Faker::Lorem.word }
  end
end
