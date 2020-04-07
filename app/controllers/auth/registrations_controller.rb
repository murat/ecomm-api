# frozen_string_literal: true
class Auth::RegistrationsController < ApplicationController
  def create
    build_resource(sign_up_params)
    resource.save

    if resource.persisted?
      expire_data_after_sign_in! unless resource.active_for_authentication?
    else
      clean_up_passwords resource
      set_minimum_password_length
    end

    render json: resource
  end
end
