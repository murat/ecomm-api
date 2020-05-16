# frozen_string_literal: true
module Api::V1
  class CartsController < Api::V1::BaseController
    before_action -> { doorkeeper_authorize! }
    before_action :set_cart

    # GET /cart
    def show
      render_with_meta(@cart.carts_products, include: [:product, :'product.brand', :'product.category'])
    end

    # POST /cart/add_product
    def add_product
      # request body receiving int params as strings.
      # that's way I use `.to_i`
      @cart.add_product(params[:product_id], params[:amount].to_i)

      render_with_meta(@cart.carts_products)
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = current_user.cart || Cart.create(user: current_user)
    end
  end
end
