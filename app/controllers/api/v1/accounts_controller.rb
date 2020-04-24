# frozen_string_literal: true
module Api::V1
  class AccountsController < Api::V1::BaseController
    before_action -> { doorkeeper_authorize! }

    def show
      render_with_meta(current_user)
    end
  end
end
