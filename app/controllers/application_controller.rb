class ApplicationController < ActionController::Base
  before_action :find_projects

  def require_login
    unless current_user
      redirect_to sign_in_path, notice: "You must be logged in to access that action"
    end
  end

  include ApplicationHelper
  protect_from_forgery with: :exception

  private
  
  def find_projects
    @projects = Project.all
  end
end
