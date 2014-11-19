class MembershipsController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @membership = Membership.new
    @memberships = @project.memberships
  end

  def create
    @membership = Membership.new(allowed_params)
    if @membership.save
      redirect_to project_memberships_path
    else
      render :index
    end
  end

  def update
    membership = Membership.find(params[:id])
    membership.update(allowed_params)
    if membership.save
      redirect_to project_memberships_path, notice: "#{membership.user.full_name} was updated successfully."
    else
      render :index
    end
  end

  def destroy
    membership = Membership.find(params[:id])
    membership.destroy
    redirect_to project_memberships_path, notice:  " #{membership.user.full_name} was removed successfully."
  end

  private

  def allowed_params
    params.require(:membership).permit(:user_id, :title).merge(:project_id => params[:project_id])
  end
end
