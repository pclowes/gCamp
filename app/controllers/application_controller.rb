class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :require_login

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
end
