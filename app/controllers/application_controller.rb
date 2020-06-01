# frozen_string_literal: true
class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  respond_to :json

  protected

  def configure_permitted_parameters
    added_attrs = [:email, :name, :surname, :phone]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end

