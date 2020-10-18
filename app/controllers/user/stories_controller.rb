class User::StoriesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destory]
  before_action :correct_user,   only: [:edit, :update, :destory]

  def index
    @house = House.find(params[:house_id])
    @stories = Story.where(house_id: @house.id).page(params[:page]).per(20)
  end

  def show
    @house = House.find(params[:house_id])
    @story = Story.find(params[:id])
    @story_comments = @story.story_comments.last(10)
    @story_comment = StoryComment.new
  end

  def new
    @house = House.find(params[:house_id])
    @story = Story.new
    @kind = "ストーリーを投稿"
  end

def create
  @house = House.find(params[:house_id])
  @story = @house.stories.build(story_params)
  @story.user_id = current_user.id
  @story.house_id = @house.id
    if @story.save
      flash[:success] = "ストーリーを投稿しました!"
      redirect_to house_stories_url(@house)
    else
      flash.now[:warning] = "ストーリーの投稿に失敗しました"
      @house = House.find(params[:house_id])
      render action: :new
    end
end

def edit
  @house = House.find(params[:house_id])
  @story = Story.find(params[:id])
  @kind = "ストーリーを更新"
end

def update
  @house = House.find(params[:house_id])
  @story = Story.find(params[:id])
  @story.user_id = current_user.id
  @story.house_id = @house.id
    if @story.update(story_params)
      flash[:success] = "ストーリーを更新しました!"
      redirect_to house_stories_url(@house)
    else
      flash.now[:warning] = "ストーリーの更新に失敗しました"
      render action: :edit
    end
end

def destroy
  @story = Story.find(params[:id])
  @house = @story.house
  @story.destroy
  flash[:warning] = "ストーリーを削除しました"
  redirect_to house_stories_url(@story.house_id)
end

  private

  def story_params
    params.require(:story).permit(:title, :content, :visit_date, :story_image, {images: []})
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
      @story = current_user.stories.find_by(id: params[:id])
      redirect_to root_url if @story.nil?
    end
end