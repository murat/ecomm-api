# frozen_string_literal: true
class InsufficientStockError < StandardError
  attr_reader :available_stock

  def initialize(available_stock)
    @available_stock = available_stock
  end

  def message
    return "only #{available_stock} product available" if available_stock.positive?

    'product is out stocked'
  end
end
