class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @tasks = Task.due_date_sort
    elsif params[:priority_expired]
      @tasks = Task.priority_sort
    else
      @tasks = Task.created_at_sort
    end
  end

  def search
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = Task.title_status_search(params[:task][:title],params[:task][:status])
        render :index
      elsif params[:task][:title].present?
        @tasks = Task.title_search(params[:task][:title])
        render :index
      elsif params[:task][:status].present?
        @tasks = Task.status_search(params[:task][:status])
        render :index
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: '保存しました'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: '保存しました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: '削除しました'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :due_date, :status, :priority)
  end
end
