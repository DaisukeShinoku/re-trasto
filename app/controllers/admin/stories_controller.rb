class Admin::StoriesController < ApplicationController
  before_action :admin_user

  def index
    @house = House.find(params[:house_id])
    @stories = Story.where(house_id: @house.id)
  end

  def show
    @house = House.find(params[:house_id])
    @story = Story.find(params[:id])
    @story_comments = @story.story_comments.last(10)
  end

  # def edit
    # @house = House.find(params[:house_id])
    # @story = Story.find(params[:id])
    # @kind = "ストーリーを更新"
  # end

  # def update
  #   @house = House.find(params[:house_id])
  #   @story = Story.find(params[:id])
  #   @story.user_id = current_user.id
  #   @story.house_id = @house.id
  #     if @story.update(story_params)
  #       flash[:success] = "ストーリーを更新しました!"
  #       redirect_to admin_house_story_url(@house, @story)
  #     else
  #       flash.now[:warning] = "ストーリーの更新に失敗しました"
  #       render action: :edit
  #     end
  # end

def destroy
  @story = Story.find(params[:id])
  @house = @story.house
  @story.destroy
  flash[:warning] = "ストーリーを削除しました"
  redirect_to admin_house_stories_url(@story.house_id)
end

  # private

  # def story_params
  #   params.require(:story).permit(:title, :content, :visit_date, :story_image, {images: []})
  # end

end