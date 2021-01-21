class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        session[:admin] = user.admin
        redirect_to root_url, notce: 'Logged in!'
      else
        flash[:alert] = 'Email or password is invalid'
        render 'articles/index'
      end
  end

  def destroy
    #session[:user_id] = nil
    session.clear
    redirect_to root_url, notice: 'Logged out!'
  end
end
