class CommentsController < ApplicationController
  before_action do
    @task = Task.find(params[:task_id])
    @project = Project.find(params[:project_id])
  end

  def create
    @comment = Comment.new(params.require(:comment).permit(:comment, :task_id, :user_id).merge(:task_id => params[:task_id]))
    @comment.save
    redirect_to project_task_path(@project, @task)
  end

  def update
    Comment.find(params[:id]).update(params.require(:comment).permit(:comment, :task_id, :user_id)).merge(:task_id => params[:task_id]))
    redirect_to project_task_path(@project, @task)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to project_task_path(@project, @task)
  end


end
