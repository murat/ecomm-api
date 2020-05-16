# frozen_string_literal: true
class PurchaseLimitExceededError < StandardError
  attr_reader :limit

  def initialize(limit)
    @limit = limit
  end

  def message
    return "cannot add more than #{limit} " if limit

    'purchase limit exceeded for product'
  end
end
