class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #protect_from_forgery with: :null_session
  before_action :require_login

  private
  def not_authenticated
    redirect_to login_path, alert: "Log eerst in"
  end

  # If the current_user doesn't have the wright rights to acces, then redirect to ../public/403.html
  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => true
  end
end
