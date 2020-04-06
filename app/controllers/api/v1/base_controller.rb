# frozen_string_literal: true
module Api::V1
  class BaseController < ApplicationController
    before_action :doorkeeper_authorize!

    private

    # Find the user that owns the access token
    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
  end
end
