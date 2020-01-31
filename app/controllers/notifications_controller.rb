class NotificationsController < ApplicationController
  def index
    @user_notifications = current_user.notifications
  end

  def destroy

  end
end
