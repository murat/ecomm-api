# frozen_string_literal: true
class InsufficientStockError < StandardError
  attr_reader :available_stock

  def initialize(available_stock)
    @available_stock = available_stock
  end

  def message
    "only #{available_stock} product available"
  end
end
