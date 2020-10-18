class Admin::HouseCommentsController < ApplicationController
  before_action :admin_user

  def index
    @house = House.find(params[:id])
    @house_comments = HouseComment.where(house_id: @house.id)
  end

  def destroy
    @house = House.find(params[:id])
    @house_comment = HouseComment.find(params[:id])
    @house_comment.destroy
    flash[:warning] = "コメントを削除しました"
    redirect_to request.referrer || root_url
  end
end
