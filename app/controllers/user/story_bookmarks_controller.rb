class User::StoryBookmarksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destory]
  
  def create
    @story = Story.find(params[:id])
    @house = House.find(params[:house_id])
    story_bookmark = @story.story_bookmarks.new(user_id: current_user.id)
    story_bookmark.save
    # redirect_to request.referer
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end

  def destroy
    @story = Story.find(params[:id])
    @house = House.find(params[:house_id])
    story_bookmark = current_user.story_bookmarks.find_by(story_id: @story.id)
    story_bookmark.destroy
    # redirect_to request.referer
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end

  def index
    @user = User.find(params[:id])
    @story_bookmarks = StoryBookmark.where(user_id: @user.id).all.page(params[:page]).per(20)
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  private

  def redirect
    case params[:redirect_id].to_i
    when 0
      redirect_to houses_path
    when 1
      redirect_to house_path(@house)
    end
  end

end