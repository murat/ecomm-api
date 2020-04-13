# frozen_string_literal: true
FactoryBot.define do
  factory :carts_product do
    cart
    product
    amount { rand(10) }
  end
end
