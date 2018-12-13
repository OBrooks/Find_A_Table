class CalendarController < ApplicationController
    def display_calendar
        if user_signed_in?
            @date = params[:date] ? Date.parse(params[:date]) : Date.today
            @user_sessions = current_user.sessions
        else
            redirect_to root_path
        end
    end
end
