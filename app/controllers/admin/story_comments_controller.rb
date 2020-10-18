class Admin::StoryCommentsController < ApplicationController
  before_action :admin_user

  def index
    @story = Story.find(params[:id])
    @house = House.find(params[:house_id])
    @story_comment = StoryComment.where(story_id: @story.id)
  end

  def destroy
    @story = Story.find(params[:story_id])
    @house = House.find(params[:house_id])
    @story_comment = StoryComment.find(params[:id])
    @story_comment.destroy
    flash[:warning] = "コメントを削除しました"
    redirect_to request.referrer || root_url
  end

end