class TasksController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  require 'csv'

    def index
    if params[:task_filter] == "all"
      @tasks = @project.tasks.order(params[:sort_by]).page(params[:page])
    elsif params[:task_filter] == "incomplete"
      @tasks = @project.tasks.where(complete: false).order(params[:sort_by]).page(params[:page])
    else
      @tasks = @project.tasks.where(complete: false).order(params[:sort_by]).page(params[:page])
    end
    csv(@tasks)
  end

  def show
      @comment = @task.comments.new
      @comments = @task.comments.all
  end

  def new
    @task = @project.tasks.new
  end

  def edit
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end


  def update
    if @task.update(task_params)
      if params[:source]== "index"
        redirect_to project_tasks_url(task_filter: params[:task_filter], sort_by: params[:sort_by]), notice: 'Task was successfully updated.'
      else
        redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.'
      end
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.'
  end

  private

  def csv(file)
    file
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"task-list\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :complete, :due_date)
  end
end
