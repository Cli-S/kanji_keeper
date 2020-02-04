class NotificationsController < ApplicationController
  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy!
    redirect_to root_path
  end

  def destroy_all
    @user_notifications = current_user.notifications
    @user_notifications.destroy_all
    redirect_to root_path
  end
end
