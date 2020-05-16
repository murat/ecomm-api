# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Cart, type: :model do
  it { should have_many(:carts_products).dependent(:destroy) }
  it { should have_many(:products).through(:carts_products) }

  describe 'methods' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:cart) { FactoryBot.create(:cart, user: user) }

    it 'adds product into cart if amount available and purchase limit does not exceeded' do
      product = FactoryBot.create(:product, purchase_limit: 10, stock: 10)

      expect(cart.add_product(product.id, 5)).to_not be_falsey
    end

    it 'raises PurchaseLimitExceededError if limit exceeded' do
      product = FactoryBot.create(:product, purchase_limit: 5, stock: 100)

      expect { cart.add_product(product.id, 10) }.to raise_error(PurchaseLimitExceededError)
    end

    it 'raises InsufficientStockError if product does not exist enough' do
      product = FactoryBot.create(:product, purchase_limit: 0, stock: 5)
      expect { cart.add_product(product.id, 10) }.to raise_error(InsufficientStockError)
    end
  end
end
