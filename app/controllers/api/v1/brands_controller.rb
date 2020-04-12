# frozen_string_literal: true
module Api::V1
  class BrandsController < Api::V1::BaseController
    skip_before_action :public_authorization, only: [:create, :update, :destroy]
    before_action :sudo_authorization, only: [:create, :update, :destroy]

    before_action :set_brand, only: [:show, :update, :destroy]

    # GET /brands
    def index
      @brands = Brand.all

      render_with_meta(@brands.page(params[:page]).per(params[:per]), paginated: true, total: @brands.count)
    end

    # GET /brands/1
    def show
      render_with_meta(@brand)
    end

    # POST /brands
    def create
      @brand = Brand.new(brand_params)
      render_with_meta(@brand, status: :created) if @brand.save!
    end

    # PATCH/PUT /brands/1
    def update
      render_with_meta(@brand, status: :ok) if @brand.update!(brand_params)
    end

    # DELETE /brands/1
    def destroy
      @brand.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def brand_params
      params.require(:brand).permit(:name, :description)
    end
  end
end
