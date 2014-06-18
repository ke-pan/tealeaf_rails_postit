class SessionsController < ApplicationController
  
  def new

  end

  def create

    @user = User.find_by(username: params[:username])
    # binding.pry
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "You were logged in."
      redirect_to root_path
    else
      flash[:error] = "Something wrong about your user name or password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You were logged out."
    redirect_to root_path
  end

end