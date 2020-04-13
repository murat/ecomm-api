# frozen_string_literal: true
class CartSerializer
  include FastJsonapi::ObjectSerializer

  has_many :products
end
