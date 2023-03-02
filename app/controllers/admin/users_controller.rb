class Admin::UsersController < ApplicationController
before_action :admin_user
before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.select(:id, :name, :email, :created_at, :updated_at, :admin).includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "保存しました"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: '保存しました'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: '削除しました'
  end

  private
  def admin_user
    if !current_user.admin?
      redirect_to tasks_path, notice: '管理者以外はアクセス出来ません'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
