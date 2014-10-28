class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  require 'csv'

  # GET /tasks
  # GET /tasks.json
  def index
    if params[:task_filter] == "all"
      @tasks = Task.order(params[:sort_by])
    elsif params[:task_filter] == "incomplete"
      @tasks = Task.where(complete: false).order(params[:sort_by])
    else
      @tasks = Task.where(complete: false).order(params[:sort_by])
    end
    csv(@tasks)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html {
          if params[:source]== "index"
            redirect_to tasks_url, notice: 'Task was successfully updated.'
          else
            redirect_to @task, notice: 'Task was successfully updated.'
          end
        }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def csv(file)
      file
      respond_to do |format|
        format.html
        format.csv do
          headers['Content-Disposition'] = "attachment; filename=\"task-list\""
          headers['Content-Type'] ||= 'text/csv'
       end
    end

    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :complete, :due_date, :source)
    end
  end
end
