# frozen_string_literal: true
class CartService
  attr_reader :user, :cart, :products

  def initialize(user)
    @user = user
    @cart = user.cart || Cart.create(user: user)
    @products = @cart.carts_products
  end

  def add(product_id, amount)
    p = cart_product(product_id)
    amount += p.amount
    product = Product.find(p.product_id)

    raise PurchaseLimitExceededError, product.purchase_limit if product.purchase_limit.positive? && product.purchase_limit < amount
    raise InsufficientStockError, p.available_stock if amount > p.available_stock

    p.assign_attributes(amount: amount)

    return false unless p.save!

    true
  end

  def update(product_id, amount)
    return false unless cart_product(product_id).update!(amount: amount)

    true
  end

  def increment(product_id)
    return false unless cart_product(product_id).increment!(:amount, 1)

    true
  end

  def decrement(product_id)
    return false unless cart_product(product_id).decrement!(:amount, 1)

    true
  end

  def remove(product_id)
    return false unless cart_product(product_id).destroy!

    true
  end
  alias drop remove

  private

  def cart_product(product_id)
    @products.find_or_create_by(product_id: product_id)
  end
end
