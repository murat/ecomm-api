# frozen_string_literal: true
module Api::V1
  class OrdersController < Api::V1::BaseController
    before_action -> { doorkeeper_authorize! }
    before_action :set_order, only: [:show, :update]

    # GET /orders
    def index
      @orders = Order.all

      render_with_meta(@orders.page(params[:page]).per(params[:per]), paginated: true, total: @orders.count)
    end

    # GET /orders/1
    def show
      render_with_meta(@order)
    end

    # POST /orders
    def create
      order =
        OrderCreateService.new(
          current_user,
          shipping_address: order_params[:shipping_address_id],
          invoice_address: order_params[:invoice_address_id]
        ).create

      render_with_meta(order, status: :created) unless order.nil?
    end

    # PATCH/PUT /orders/1
    def update
      render_with_meta(@order, status: :ok) if @order.update!(order_params)
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:shipping_address_id, :invoice_address_id)
    end
  end
end
