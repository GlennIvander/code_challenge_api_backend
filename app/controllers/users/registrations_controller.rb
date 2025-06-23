# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix
  respond_to :json

  #   before_action :configure_permitted_parameters

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  # end
  #
  private

  def respond_with(resource, _opts = {})
    if request.method == "POST" && resource.persisted?
      render json: { message: "Signed up sucessfully.", data: resource }, status: :ok
    elsif request.method == "DELETE"
      render json: { message: "Account deleted successfully." }, status: :ok
    else
      render json: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }, status: :unprocessable_entity
    end
  end
end
