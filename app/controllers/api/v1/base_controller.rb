# frozen_string_literal: true
module Api::V1
  class BaseController < ActionController::API
    include ErrorHandler

    before_action :public_authorization

    respond_to :json

    private

    def public_authorization
      doorkeeper_authorize!
    end

    def sudo_authorization
      doorkeeper_authorize!(:sudo)
    end

    # Find the user that owns the access token
    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
    alias current_user current_resource_owner
  end
end
