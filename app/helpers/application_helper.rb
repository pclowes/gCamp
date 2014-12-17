module ApplicationHelper
  def page_header(title, &block)
    unless content_for(:title)
      content_for(:title, title)
    end
    html = '<div class="page-header">'.html_safe
    if block
      html += '<div class="pull-right">'.html_safe
      html += capture do
        block.call
      end
      html += '</div>'.html_safe
    end
    html += '<h1>'.html_safe
    html += title
    html += '</h1>'.html_safe
    html += '</div>'.html_safe
    html
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def admin_projects
    Project.all
  end
end
