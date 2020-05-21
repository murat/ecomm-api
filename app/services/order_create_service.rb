# frozen_string_literal: true
require 'securerandom'

class OrderCreateService
  attr_reader :user, :cart, :products,
              :shipping_address, :invoice_address,
              :errors

  def initialize(user, shipping_address:, invoice_address:)
    @user = user
    @cart = @user.cart
    @products = @cart.carts_products
    @shipping_address = shipping_address
    @invoice_address = invoice_address

    @errors = []
  end

  def create
    raise EmptyCartError if products.count.zero?

    products.each do |p|
      raise "#{p.product.name} has only #{p.available_stock} stock" unless p.is_available?
    end

    order = Order.new
    ActiveRecord::Base.transaction do
      order.assign_attributes(
        shipping_address_id: shipping_address,
        invoice_address_id: invoice_address,
        user_id: user.id,
        order_no: SecureRandom.uuid,
        status: initial_status
      )
      order.save!

      products.each do |p|
        OrdersProduct.create(order: order,
                             product: p.product,
                             amount: p.amount,
                             price: p.product.discounted_price)

        p.product.decrement!(:stock, p.amount)
      end

      # finally
      products.destroy_all
      return order
    end

    false
  end

  def initial_status
    # @todo: implement this
    'pending'
  end
end
