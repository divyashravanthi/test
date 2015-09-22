class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # around_filter :user_time_zone, if: :current_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name << :role << :avatar << :about << :time_zone
      devise_parameter_sanitizer.for(:account_update) << :name << :role << :avatar << :about << :time_zone
    end

    def user_time_zone(&block)
    	Time.use_zone(current_user.time_zone, &block)
    end

end
