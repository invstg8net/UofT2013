class SessionsController < ApplicationController
  

def new
  if current_user
    redirect_to root_url + "researchers/questions"
  end
    
end

def create
  user = Researcher.authenticate(params[:email], params[:password])
  if user
    if user.status > 0 or user.Is_Admin
      session[:user_id] = user.id
      redirect_to root_url + "researchers/questions", :notice => "Logged in!"
    else
      flash.now[:alert] = "Account inactive"
      render "new"
    end
  else
    flash.now[:alert] = "Invalid email or password"
    render "new"
  end
end

def destroy
  session[:user_id] = nil
  redirect_to root_url, :notice => "Logged out!"
end


end
