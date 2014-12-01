class ApplicationController < ActionController::Base
  def require_login
    unless current_user
      redirect_to sign_in_path, notice: "You must be logged in to access that action"
    end
  end

  include ApplicationHelper
  protect_from_forgery with: :exception

  def find_project
    @projects = Project.all
  end
end
