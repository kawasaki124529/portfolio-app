# frozen_string_literal: true

class ApplicationController < ActionController::API
  skip_before_action :verify_authenticity_token, if: :devise_controller?, raise: false # APIではCSRFチェックをしない(トークンが有るため)
  include DeviseTokenAuth::Concerns::SetUserByToken
end
