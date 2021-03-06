class MembershipsController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end
  before_action :authorize_member, only: [:index]
  before_action :authorize_owner, only: [:new, :create, :edit, :update]
  before_action :authorize_destroy, only: [:destroy]


  def index
    @membership = Membership.new
    @memberships = @project.memberships
  end

  def create
    @membership = Membership.new(allowed_params)
    if @membership.save
      redirect_to project_memberships_path(@project), notice: 'Membership was successfully created.'
    else
      render :index
    end
  end


  def update
    membership = Membership.find(params[:id])
    if membership.update(allowed_params)
      redirect_to project_memberships_path, notice: "#{membership.user.full_name} was updated successfully."
    elsif membership.check_update == false
      redirect_to project_memberships_path, notice:  "Can't change the last owner of a project to a member"
    else
      render :index
    end
  end


  def destroy
    if membership = Membership.find(params[:id]).destroy
      if current_user.admin? || current_user.owner?(@project) || current_user == @user
        redirect_to project_memberships_path, notice:  " #{membership.user.full_name} was removed successfully."
      else
        redirect_to projects_path
      end
    else
      redirect_to project_memberships_path, notice:  "Can't delete the last owner of a project"
    end
  end

  private

  def allowed_params
    params.require(:membership).permit(:user_id, :title).merge(:project_id => params[:project_id])
  end

  def authorize_member
    raise AccessDenied unless current_user.member?(@project) || current_user.admin?
  end

  def authorize_owner
    raise AccessDenied unless current_user.owner?(@project) || current_user.admin?
  end

  def authorize_destroy
    membership = Membership.find(params[:id])
    raise AccessDenied unless current_user.admin? || current_user.owner?(@project)|| current_user == membership.user
  end
end
