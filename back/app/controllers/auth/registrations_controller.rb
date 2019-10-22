class Auth::RegistrationsController < ApplicationController
  private
    def sign_up_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
    def account_update_params
      params.permit(:name, :email)
    end
  end
