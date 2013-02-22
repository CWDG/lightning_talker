class ApplicationController < ActionController::Base
  include AnalyticsTracker

  helper_method :current_user, :signed_in?
  protect_from_forgery

  def require_authentication!
    redirect_to sign_in_path, alert: 'You must sign in to access that page.' unless signed_in?
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def signed_in?
    current_user.present?
  end

end
