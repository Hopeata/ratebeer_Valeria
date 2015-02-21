class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password]) && !user.cold
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back!"
    elsif user && user.authenticate(params[:password]) && user.cold
      redirect_to :back, notice: "Your account is frozen, please contact the admin"
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

end