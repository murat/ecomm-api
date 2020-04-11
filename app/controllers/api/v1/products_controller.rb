# frozen_string_literal: true
module Api::V1
  class ProductsController < Api::V1::BaseController
    before_action :set_product, only: [:show, :update, :destroy]

    # GET /products
    def index
      @products = Product.all

      render json: @products
    end

    # GET /products/1
    def show
      render json: @product
    end

    # POST /products
    def create
      @product = Product.new(product_params)

      render json: @product, status: :created if @product.save!
    end

    # PATCH/PUT /products/1
    def update
      render json: @product if @product.update!(product_params)
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
      params.require(:product).permit(:name, :description, :brand_id, :category_id)
    end
  end
end
