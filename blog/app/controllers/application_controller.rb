class ApplicationController < ActionController::Base
  before_filter :authorize
  protect_from_forgery

  private
 
  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == 'admin' && password == 'password'
    end
  end

  protected

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, :notice => "Please log in"
    end
  end

end
