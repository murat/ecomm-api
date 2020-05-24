# frozen_string_literal: true
require 'rails_helper'
require 'cart_service'

RSpec.describe 'CartService' do
  it 's happy path' do
    user = FactoryBot.create(:user)
    product = FactoryBot.create(:product, purchase_limit: 0, stock: 10)
    service = CartService.new(user)

    assert service.add(product.id, 3)
    expect { service.add(product.id, 8) }.to raise_error(InsufficientStockError)
    assert service.decrement(product.id)
    assert service.add(product.id, 8)
  end
end
