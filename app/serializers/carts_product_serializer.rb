# frozen_string_literal: true
class CartsProductSerializer
  include FastJsonapi::ObjectSerializer

  attributes :amount
  belongs_to :product
end
