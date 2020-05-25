# frozen_string_literal: true
class CartsProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def available_stock
    product.available_stock + amount
  end
end
