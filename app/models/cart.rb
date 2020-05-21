# frozen_string_literal: true
class Cart < ApplicationRecord
  belongs_to :user

  has_many :carts_products, dependent: :destroy
  has_many :products, -> { readonly }, through: :carts_products
end
