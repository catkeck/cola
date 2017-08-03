class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  #defines user that is currently logged in
  def current_user
    @current_user ||= User.find_by(id: session[:id])
  end

  #checks if there is a user logged in
  def logged_in?
    !!current_user
  end

end
