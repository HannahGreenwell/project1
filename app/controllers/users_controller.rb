class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.create user_params

    if user.persisted?
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def show
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    unless @user.id == @current_user.id
      redirect_to products_path
      return
    end

    if @user.update user_params
      redirect_to user_path(@user)
    else
      flash[:errors] = @user.errors.full_messages
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
