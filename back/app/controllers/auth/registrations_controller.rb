module Auth
  class RegistrationsController < DeviseTokenAuth::RegistrationsControlle
    private
    # ストロングパラメーター設定
    def sign_up_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
    def account_update_params
      params.permit(:name, :email)
    end
  end
 end