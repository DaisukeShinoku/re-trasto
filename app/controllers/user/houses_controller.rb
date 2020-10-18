class User::HousesController < ApplicationController

  def index
    @houses = SearchHousesForm.new(params).result
    @categories = Category.where(is_valid: true).shuffle.first(5)
    @house_areas = HouseArea.all
  end

  def show
    @house = House.find(params[:id])
    @stories = Story.where(house_id: @house.id).shuffle.first(3)
    @categories = Category.where(is_valid: true).shuffle.first(5)
    @house_areas = HouseArea.all
    @house_comments = HouseComment.where(house_id: @house.id).last(5)
    @house_comment = HouseComment.new
  end

    # ログイン済みユーザーかどうか確認
    # def logged_in_user
      # unless logged_in?
        # store_location
        # flash[:warning] = "Please log in."
        # redirect_to login_url
      # end
    # end

    # 正しいユーザーかどうか確認
    # def correct_user
      # @user = User.find(params[:id])
      # redirect_to(root_url) unless current_user?(@user)
    # end

    # お気に入り機能
    # def bookmarks
      # @houses = current_user.bookmark_houses.includes(:user)
    # end
end