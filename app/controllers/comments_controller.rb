class CommentsController < ApplicationController
  before_action :require_login
  before_action do
    @task = Task.find(params[:task_id])
    @project = Project.find(params[:project_id])
  end

  def create
    @comment = @task.comments.new(comment_params)
    @comment.save
    redirect_to project_task_path(@project, @task)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to project_task_path(@project, @task)
  end

  def comment_params
    params.require(:comment).permit(:comment)
      .merge(user: current_user)
  end

end
