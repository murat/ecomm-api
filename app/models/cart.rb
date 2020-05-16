# frozen_string_literal: true
class Cart < ApplicationRecord
  belongs_to :user

  has_many :carts_products, dependent: :destroy
  has_many :products, -> { readonly }, through: :carts_products

  def add_product(product_id, amount)
    added = carts_products.find_or_initialize_by(product_id: product_id)
    amount += added.amount
    product = Product.find(product_id)

    raise PurchaseLimitExceededError, product.purchase_limit if product.purchase_limit.positive? && product.purchase_limit < amount
    raise InsufficientStockError, product.available_stock if product.available_stock < amount

    added.assign_attributes(amount: amount)
    return false unless added.save!

    true
  end
end
