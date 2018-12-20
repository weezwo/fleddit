class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:message] = "Something went wrong!"
      redirect_to login_path
    end
  end

  def create_from_omniauth
    @user = User.find_or_create_by(email: auth[:info][:email]) do |user|
      user.username = auth[:info][:name]
      user.password = SecureRandom.hex
    end

    session[:user_id] = @user.id

    if logged_in?
      flash[:message] = "Successfully authenticated via Google!"
    else
      flash[:message] = "Something went wrong. Try again."
    end

    redirect_to root_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private
 
  def auth
    request.env['omniauth.auth']
  end
end
