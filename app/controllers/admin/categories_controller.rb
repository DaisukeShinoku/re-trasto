class Admin::CategoriesController < ApplicationController
  before_action :admin_user

  def index
    @categories_all = Category.all
    @category = Category.new
    @categories = Category.where(is_valid: true).shuffle.first(5)
    @house_areas = HouseArea.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "カテゴリーを作成しました"
      redirect_to admin_categories_path
    else
      flash.now[:warning] = "カテゴリーの作成に失敗しました"
      render action: :index
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "カテゴリーを更新しました"
      redirect_to admin_categories_path
    else
      flash.now[:warning] = "カテゴリーの更新に失敗しました"
      render action: :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:danger] = "カテゴリーを削除しました"
    redirect_to admin_categories_path
  end

  private

  def category_params
      params.require(:category).permit(:name, :is_valid, :category_image)
  end

  def set_category
      @category = Category.find(params[:id])
  end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end