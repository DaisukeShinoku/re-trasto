class User::HouseCommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destory]
  before_action :correct_user,   only: [:destroy]

  def index
    @house = House.find(params[:id])
    @house_comments = HouseComment.where(house_id: @house.id).page(params[:page]).per(20)
  end

  def create
    @house = House.find(params[:id])
    @house_comment = @house.house_comments.build(house_comment_params)
    @house_comment.user_id = current_user.id
    @house_comment.house_id = @house.id
    if @house_comment.save
      flash[:success] = "応援コメントを投稿しました!"
      redirect_to request.referrer || root_url
    else
      flash.now[:warning] = "応援コメントの投稿に失敗しました、140文字以内で投稿してください。"
      @house = House.find(params[:id])
      @stories = Story.where(house_id: @house.id).shuffle.first(3)
      @categories = Category.where(is_valid: true).shuffle.first(5)
      @house_areas = HouseArea.all
      @house_comments = HouseComment.where(house_id: @house.id).last(5)
      render 'user/houses/show'
    end
  end

  def destroy
    @house = House.find(params[:id])
    @house_comment = HouseComment.find(params[:id])
    @house_comment.destroy
    flash[:warning] = "コメントを削除しました"
    redirect_to request.referrer || root_url
  end

  private

  def house_comment_params
    params.require(:house_comment).permit(:content)
  end

  def correct_user
    @house_comment = current_user.house_comments.find_by(id: params[:id])
    redirect_to root_url if @house_comment.nil?
  end
end