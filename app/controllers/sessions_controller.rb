class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      sign_in(user)
      redirect_to root_path
    else
      flash.now[:error] = "Incorrect username/password."
      render 'new'
    end
  end

  def destroy
    sign_out
    render 'new'
  end
end
