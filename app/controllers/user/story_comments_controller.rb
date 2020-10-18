class User::StoryCommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destory]

  def index
    @story = Story.find(params[:id])
    @house = House.find(params[:house_id])
    @story_comment = StoryComment.where(story_id: @story.id).page(params[:page]).per(20)
  end
  
  def create
    @story = Story.find(params[:id])
    # @story = Story.find(params[:story_id])
    @house = House.find(params[:house_id])
    @story_comment = @story.story_comments.build(story_comment_params)
    @story_comment.user_id = current_user.id
    @story_comment.story_id = @story.id
    if @story_comment.save
      flash[:success] = "ストーリーにコメントしました!"
      redirect_to request.referrer || root_url
    else
      flash[:warning] = "コメントに失敗しました、140文字以内でコメントしてください"
      @house = House.find(params[:house_id])
      @story = Story.find(params[:id])
      @story_comments = @story.story_comments.last(10)
      render 'user/stories/show'
    end
  end

  def destroy
    # @story = Story.find(params[:id])
    @story = Story.find(params[:story_id])
    @house = House.find(params[:house_id])
    @story_comment = StoryComment.find(params[:id])
    @story_comment.destroy
    flash[:warning] = "コメントを削除しました"
    redirect_to request.referrer || root_url
  end

  private

  def story_comment_params
    params.require(:story_comment).permit(:content)
  end

  def correct_user
    @story_comment = current_user.story_comments.find_by(id: params[:id])
    redirect_to root_url if @story_comment.nil?
  end

end