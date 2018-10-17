class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:email]

    if user.present? && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to products_path
    else
      flash[:login_error] = "Please check your email and password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
