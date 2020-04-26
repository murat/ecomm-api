# frozen_string_literal: true
module Api::V1
  class AddressesController < Api::V1::BaseController
    before_action -> { doorkeeper_authorize! }
    before_action :set_address, only: [:show, :update, :destroy]

    # GET /addresses
    def index
      @addresses = Address.all

      render_with_meta(@addresses.page(params[:page]).per(params[:per]), paginated: true, total: @addresses.count)
    end

    # GET /addresses/1
    def show
      render_with_meta(@address)
    end

    # POST /addresses
    def create
      @address = Address.new(address_params.merge(user_id: current_user.id))
      render_with_meta(@address, status: :created) if @address.save!
    end

    # PATCH/PUT /addresses/1
    def update
      render_with_meta(@address, status: :ok) if @address.update!(address_params)
    end

    # DELETE /addresses/1
    def destroy
      @address.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def address_params
      params.require(:address).permit(:title, :address, :country, :city, :county, :zip_code, :phone)
    end
  end
end
