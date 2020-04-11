# frozen_string_literal: true
FactoryBot.define do
  factory :category do
    ancestry { '' }
    position { 1 }
    name { Faker::Commerce.department.split(',').sample.strip }
  end
end
