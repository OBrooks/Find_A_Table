class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications
  end

  def mark_all_as_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    redirect_back fallback_location: root_path
  end

  def mark_as_read
    @notifications = Notification.find(params[:id])
    @notifications.update!(read_at: Time.zone.now)
    redirect_to params[:url]
  end
end
