class ApplicationController < ActionController::Base
    before_action :sanitize_devise_params, if: :devise_controller?
    
    def sanitize_devise_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :nickname, :town, :adress, :status, :gender, :profile_picture, :experience, :description, :birthdate])
        devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :nickname, :town, :adress, :status, :gender, :profile_picture, :experience, :description, :birthdate])
    end    
end