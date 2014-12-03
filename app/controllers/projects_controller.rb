class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authorize_member, only: [:show]
  before_action :authorize_owner, only: [:edit, :update, :destroy]
  def index
    @projects = current_user.projects
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_tasks_path(@project), notice: 'Project was successfully created.'
      Membership.create(project_id: @project.id, user_id: current_user.id, title: "Owner")
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    #project_id has to match
    #role = owner
    #user_id current user
    # memberships = @project.memberships.where(role: 'owner', user_id: current_user)
    # if memberships.empty?
    #   render 'public/404', status: 404
    # else
      @project.destroy
      redirect_to projects_url, notice: 'Project was successfully destroyed.'
    # end
  end

  def edit
  end

  private
    def project_params
      params.require(:project).permit(:name)
    end

    def set_project
      @project = Project.find(params[:id])
    end

    def authorize_member
      raise AccessDenied unless current_user.member?(@project)
    end

    def authorize_owner
      raise AccessDenied unless current_user.owner?(@project)
    end

end
