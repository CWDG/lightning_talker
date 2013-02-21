class ApplicationController < ActionController::Base
  helper_method :current_user, :signed_in?
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def signed_in?
    current_user.present?
  end
end
