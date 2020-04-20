# frozen_string_literal: true
module Api::V1
  class ProductsController < Api::V1::BaseController
    prepend_before_action -> { authorize_request(:admin) }, only: [:create, :update, :destroy]
    before_action :set_product, only: [:show, :update, :destroy]

    # GET /products
    def index
      @products = Product.all

      render_with_meta(@products.page(params[:page]).per(params[:per]), paginated: true, total: @products.count)
    end

    # GET /products/1
    def show
      render_with_meta(@product)
    end

    # POST /products
    def create
      @product = Product.new(product_params)

      render_with_meta(@product, status: :created) if @product.save!
    end

    # PATCH/PUT /products/1
    def update
      render_with_meta(@product) if @product.update!(product_params)
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
