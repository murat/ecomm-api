# frozen_string_literal: true
module Api::V1
  class CategoriesController < Api::V1::BaseController
    before_action -> { doorkeeper_authorize! }, only: [:index, :show]
    before_action only: [:create, :update, :destroy] do
      doorkeeper_authorize! :admin
    end

    before_action :set_category, only: [:show, :update, :destroy]

    # GET /categories
    def index
      @categories = Category.all

      if params[:style] == 'raw'
        render json: { data: @categories.roots.map(&->(c) { c.subtree.arrange_serializable }).flatten }, status: :ok
        return
      end

      render_with_meta(@categories.page(params[:page]).per(params[:per]), paginated: true, include: [:children], total: @categories.count)
    end

    # GET /categories/1
    def show
      render_with_meta(@category)
    end

    # POST /categories
    def create
      @category = Category.new(category_params)
      render_with_meta(@category, status: :created) if @category.save!
    end

    # PATCH/PUT /categories/1
    def update
      render_with_meta(@category) if @category.update!(category_params)
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
