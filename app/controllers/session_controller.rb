class SessionController < ApplicationController

  # login form
  def new
  end

  # login
  def create
    user = User.find_by email: params[:email]

    # Check that the user exists and the entered the correct password
    if user.present? && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to products_path
    else
      # Redirect user's with bad credentials back
      # to the login page and set a flash error
      flash[:login_error] = "Please check your email and password."
      redirect_to login_path
    end
  end

  # logout
  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
