class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.shuffle.first(3)
    @stories = @user.stories.shuffle.first(3)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id)
      flash[:success] = "ユーザー情報を更新しました"
    else
      flash.now[:warning] = "ユーザー情報の更新に失敗しました"
      render action: :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:warning] = "ユーザーを削除しました"
    redirect_to admin_users_url
  end

  def tweets
    @user = User.find(params[:id])
    @tweets = @user.tweets.all
  end

  def stories
    @user = User.find(params[:id])
    @stories = @user.stories.all
  end

  private
  def user_params
    params.require(:user).permit(:account_name, :display_name, :email, :password, :password_confirmation, :introduction, :avatar, :is_valid)
  end
    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end