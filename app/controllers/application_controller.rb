class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin!
    return redirect_to root_url unless admin_user? && authenticate_user!
  end

  private

  def admin_user?
    current_user && current_user.admin?
  end
end
