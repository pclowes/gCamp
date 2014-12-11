class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :authorize_admin, only: [:new, :create]

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
    if @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_url, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if current_user.admin?
      @user.destroy
      redirect_to users_path, notice: 'User was successfully destroyed.'
    else
      @user.destroy
      redirect_to signin_path, notice: 'User was successfully destroyed.'
    end
  end

  private

  def user_params
    if current_user.admin?
      params.require(:user).permit(:first_name, :last_name, :email, :password, :tracker_token, :admin)
    else
      params.require(:user).permit(:first_name, :last_name, :email, :password, :tracker_token)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end


  def authorize_user
    raise AccessDenied unless current_user == @user || current_user.admin?
  end

  def authorize_admin
    raise AccessDenied unless current_user.admin?
  end
end
