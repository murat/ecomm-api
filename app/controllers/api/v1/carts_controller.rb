# frozen_string_literal: true
module Api::V1
  class CartsController < Api::V1::BaseController
    before_action -> { doorkeeper_authorize! }
    before_action :set_cart

    # GET /cart
    def show
      render_with_meta(@cart.carts_products, include: [:product, :'product.brand', :'product.category'])
    end

    # POST /cart/insert
    def insert
      @product = Product.find(params[:product_id])

      raise "#{@product&.name} outstocked" if @product.stock_count < params[:amount]

      ActiveRecord::Base.transaction do
        if @cart.product_ids.include?(@product.id)
          exist = @cart.carts_products.find_by(product_id: @product.id)
          exist.update(amount: exist.amount + params[:amount])
        else
          @cart.products << @product
        end

        @product.update(stock_count: (@product.stock_count - params[:amount]))
      end

      render_with_meta(@cart.carts_products)
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = current_user.cart || Cart.create(user: current_user)
    end
  end
end
