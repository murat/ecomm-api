# frozen_string_literal: true
module Api::V1
  class ProductsController < Api::V1::BaseController
    before_action -> { doorkeeper_authorize! }, only: [:index, :show]
    before_action only: [:create, :update, :destroy] do
      doorkeeper_authorize! :admin
    end

    before_action :set_product, only: [:show, :update, :destroy]

    # GET /products
    def index
      @products = Product.all

      render_with_meta(@products.page(params[:page]).per(params[:per]), paginated: true, include: [:category, :brand], total: @products.count)
    end

    # GET /products/1
    def show
      render_with_meta(@product, include: [:category, :brand])
    end

    # POST /products
    def create
      @product = Product.new(product_params)

      render_with_meta(@product, include: [:category, :brand], status: :created) if @product.save!
    end

    # PATCH/PUT /products/1
    def update
      render_with_meta(@product, include: [:category, :brand]) if @product.update!(product_params)
    end

    # DELETE /products/1
    def destroy
      @product.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :brand_id, :category_id,
                                      discounts_attributes: [:id, :discount, :start_time, :end_time, :_destroy],
                                      specifications_attributes: [:id, :spec_key, :spec_val, :_destroy])
    end
  end
end
