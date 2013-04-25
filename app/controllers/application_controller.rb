class ApplicationController < ActionController::Base
    #http_basic_authenticate_with(:name => "user", :password => "hello")
  helper_method :current_user

  private

  def current_user
    @current_user ||= Researcher.find(session[:user_id]) if session[:user_id]
  end
  def current_admin
    @admin ||= Researcher.find(session[:user_id]) if session[:user_id]
    @current_admin = Researcher.where("email = ?", @admin.email).first
  end
end

