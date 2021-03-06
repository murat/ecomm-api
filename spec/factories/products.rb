# frozen_string_literal: true
FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    brand
    category
    purchase_limit { rand(100) }
    stock { rand(1000) }

    trait :with_specifications do
      specifications_attributes do
        [
          FactoryBot.attributes_for(:specification),
          FactoryBot.attributes_for(:specification),
        ]
      end
    end

    trait :with_discount do
      discounts_attributes do
        [
          FactoryBot.attributes_for(:discount),
        ]
      end
    end
  end
end
