# frozen_string_literal: true
module Api::V1
  class CategoriesController < Api::V1::BaseController
    before_action :set_category, only: [:show, :update, :destroy]

    # GET /categories
    def index
      @categories = Category.all

      render json: @categories
    end

    # GET /categories/1
    def show
      render json: @category
    end

    # POST /categories
    def create
      @category = Category.new(category_params)

      render json: @category, status: :created if @category.save!
    end

    # PATCH/PUT /categories/1
    def update
      render json: @category if @category.update!(category_params)
    end

    # DELETE /categories/1
    def destroy
      @category.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:ancestry, :position, :name)
    end
  end
end
