# frozen_string_literal: true
module Api::V1
  class CartsController < Api::V1::BaseController
    before_action :set_cart

    # GET /cart
    def show
      render_with_meta(@cart.products)
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = current_user.cart || Cart.create(user: current_user)
    end
  end
end
