class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      @user.save
      format.html { redirect_to users_path, notice: 'User was successfully created.' }
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
