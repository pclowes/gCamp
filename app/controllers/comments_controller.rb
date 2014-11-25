class CommentsController < ApplicationController
  before_action do
    @task = Task.find(params[:task_id])
    @project = Project.find(params[:project_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to project_task_path(@project, @task)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to project_task_path(@project, @task)
  end

  def comment_params
    params.require(:comment).permit(:comment, :task_id, :user_id)
      .merge({:task_id => params[:task_id], :user_id => session[:user_id]})
  end

end
