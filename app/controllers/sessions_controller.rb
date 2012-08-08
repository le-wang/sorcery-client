class SessionsController < ApplicationController
  def new
  end

  def create
    user = Auth::User.login(params[:email], params[:password])
    auto_login(user) if user
    if user
      redirect_back_or_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Email or password was invalid"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
end
