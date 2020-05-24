# frozen_string_literal: true
class EmptyCartError < StandardError
  def message
    'did you add something to cart?'
  end
end
