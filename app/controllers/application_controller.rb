class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_notifications
  before_action :redirect_to_domain

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar])
  end

  def set_user_notifications
    if user_signed_in?
      @user_notifications = current_user.notifications
    else
      @user_notifications = []
    end
  end

  def redirect_to_domain
    domain = ENV["DOMAIN"] 

    if domain && request.host == "kanjikeeper.herokuapp.com" || request.host == "kanjikeeper.com"
      redirect_to "http://" + domain + request.path, status: :moved_permanently
    end
  end
end
