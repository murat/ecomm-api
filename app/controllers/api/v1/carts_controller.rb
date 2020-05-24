# frozen_string_literal: true
module Api::V1
  class CartsController < Api::V1::BaseController
    attr_reader :cart_service
    before_action -> { doorkeeper_authorize! }
    before_action lambda {
      @cart_service = CartService.new(current_user)
    }

    # GET /cart
    def show
      render_with_meta(cart_service.products, include: [:product, :'product.brand', :'product.category'])
    end

    # POST /cart/add
    def add
      render_with_meta(cart_service.products) if cart_service.add(params[:product_id], params[:amount].to_i)
    end

    # DELETE /cart/drop/:product_id
    def drop
      head :ok if cart_service.drop(params[:product_id])
    end

    # PUT /cart/update/:product_id
    def update
      head :ok if cart_service.update(params[:product_id], params[:amount].to_i)
    end

    # PUT /cart/increment/:product_id
    def increment
      head :ok if cart_service.increment(params[:product_id])
    end

    # PUT /cart/decrement/:product_id
    def decrement
      head :ok if cart_service.decrement(params[:product_id])
    end
  end
end
