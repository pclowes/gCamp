class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :require_login

  def require_login(return_point = request.url)
    unless current_user
      set_return_point(return_point)
      redirect_to sign_in_path, notice: "You must be logged in to access that action"
    end
  end

  def return_point
    session[:return_point] || projects_path
  end

  def set_return_point(path, overwrite = false)
    if overwrite or session[:return_point].blank?
      session[:return_point] = path
    end
  end


  class AccessDenied < StandardError
  end

  rescue_from AccessDenied, with: :render_404

  def render_404
    render "public/404", status: :not_found, layout: false
  end
end
