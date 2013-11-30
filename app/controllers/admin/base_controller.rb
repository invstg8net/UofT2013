class Admin::BaseController < ApplicationController
  #http_basic_authenticate_with(:name => "admin", :password => "rhok-toronto-2012")

  #protected
   before_filter :execute_this_for_every_action

  def execute_this_for_every_action
    @current_user ||= Researcher.find(session[:user_id]) if session[:user_id]
    if @current_user
      current_user.setPrivacy()
      email = @current_user.email
      user = Researcher.where("email = ?", email)
      is_admin = user.first.Is_Admin
      is_super = user.first.superuser
    end
    if !(@current_user) || ((is_admin == false) && (is_super == false))
      redirect_to root_url
    end
  end
end
