class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_notifications
  before_filter :redirect_to_preferred_host

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

  PREFERRED_HOST = 'www.kanjikeeper.com'
  def redirect_to_preferred_host
    if Rails.env.production? && request.host != PREFERRED_HOST
      redirect_to(host: PREFERRED_HOST)
    end
  end
end
