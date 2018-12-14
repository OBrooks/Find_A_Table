class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def mark_as_read
    @notifications = Notification.find(params[:id])
    @notifications.update!(read_at: Time.zone.now)
    redirect_to params[:url]
  end
end