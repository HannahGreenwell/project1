class UsersController < ApplicationController
  # sign-up form
  def new
    @user = User.new
  end

  # sign-up
  def create
    @user = User.create user_params

    # Check if sign-up was successful
    if @user.persisted?
      # If sign-up was successful, create a session for the user and redirect to users#show
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      # If sign-up was unsuccessful, redirect to sign-up page and set flash errors
      flash[:user_errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    # Only allow the current user to update their own information
    unless @user.id == @current_user.id
      redirect_to products_path
      return
    end

    # Check if the update was successful
    if @user.update user_params
      # If update was successful, redirect to users#show
      redirect_to user_path(@user)
    else
      # If update was unsuccessful, redirect to users#edit and set flash errors
      flash[:user_errors] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    user = User.find params[:id]
    user.destroy
    redirect_to products_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
