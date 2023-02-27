class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.due_date_sort.page(params[:page])
    elsif params[:priority_expired]
      @tasks = current_user.tasks.priority_sort.page(params[:page])
    else
      @tasks = current_user.tasks.created_at_sort.page(params[:page])
    end
  end

  def search
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = Task.title_status_search(params[:task][:title],params[:task][:status]).page(params[:page])
        render :index
      elsif params[:task][:title].present?
        @tasks = Task.title_search(params[:task][:title]).page(params[:page])
        render :index
      elsif params[:task][:status].present?
        @tasks = Task.status_search(params[:task][:status]).page(params[:page])
        render :index
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)

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
