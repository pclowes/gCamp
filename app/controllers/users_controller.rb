class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
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

  def edit
  end

  def update
    respond_to do |format|
      @user.update(user_params)
        format.html {redirect_to users_url, notice: 'User was successfully updated.'}
    end
  end



  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end

    def set_user
      @user = User.find(params[:id])
    end

end
