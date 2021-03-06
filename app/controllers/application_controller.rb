class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?


  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!


  protected

    def json_request?
      request.format.json?
    end


  private

    def authenticate_user_from_token!
      #p "authenticate_user_from_token"
      authenticate_with_http_token do |token, options|
        # p token
        # p options
        user_email = options[:email].presence
        user = user_email && User.find_by_email(user_email)

        if user && Devise.secure_comare(user.authentication_token, token)
          sign_in user, store: false
        end
      end
    end
end
