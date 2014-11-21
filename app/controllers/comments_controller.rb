class CommentsController < ApplicationController
  def index
    @comment = Comment.new
    @comments = Comment.all
  end

  def create
    @comment = Comment.new(params.require(:comment).permit(:comment, :task_id, :user_id))
    @comment.save
    redirect_to project_task_path(@project, @task)
  end

  def update
    Comment.find(params[:id]).update(params.require(:comment).permit(:comment, :task_id, :user_id))
    redirect_to project_task_path(@project, @task)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to project_task_path(@project, @task)
  end
end
