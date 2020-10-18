class User::BookmarksController < ApplicationController
  before_action :logged_in_user
  
  def create
    @house = House.find(params[:house_id])
    bookmark = @house.bookmarks.new(user_id: current_user.id)
    bookmark.save
    # redirect_to request.referer
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end

  def destroy
    @house = House.find(params[:house_id])
    bookmark = current_user.bookmarks.find_by(house_id: @house.id)
    bookmark.destroy
    # redirect_to request.referer
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end

  def index
    @user = User.find(params[:id])
    @bookmarks = Bookmark.where(user_id: @user.id).all.page(params[:page]).per(20)
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