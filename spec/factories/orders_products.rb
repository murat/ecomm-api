# frozen_string_literal: true
FactoryBot.define do
  factory :orders_product do
    order
    product
    amount { rand(10) }
    price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  end
end
