# frozen_string_literal: true
module Api::V1
  class AccountsController < Api::V1::BaseController
    def show
      render json: current_user
    end
  end
end
