class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  before_action :find_projects
  before_action :require_login
  before_action :membership_project_id_match
  before_action :membership_id_match

  def require_login
    unless current_user
      redirect_to sign_in_path, notice: "You must be logged in to access that action"
    end
  end

  class AccessDenied < StandardError
  end

  rescue_from AccessDenied, with: :render_404

  def render_404
    render "public/404", status: :not_found, layout: false
  end

  def membership_project_id_match
    project_list = Membership.where(user_id: current_user.id).pluck(:project_id)
    @project = Project.find(params[:id])
    unless project_list.include?(@project.id)
      raise AccessDenied
    end
  end

  def membership_id_match
    project_list = Membership.where(user_id: current_user.id).pluck(:project_id)
    unless project_list.include?(@project.id)
      raise AccessDenied
    end
  end

  private

  def find_projects
    @projects = Project.all
  end
end
