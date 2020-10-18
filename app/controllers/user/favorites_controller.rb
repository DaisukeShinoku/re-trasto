class User::FavoritesController < ApplicationController
  before_action :logged_in_user
  
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @favorite = current_user.favorites.new(tweet_id: @tweet.id)
    @favorite.save
    # redirect_back(fallback_location: root_path)
    end

    def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @favorite = current_user.favorites.find_by(tweet_id: @tweet.id)
    @favorite.destroy
    # redirect_back(fallback_location: root_path)
    end

    def index
      @user = User.find(params[:id])
      @favorites = Favorite.where(user_id: @user.id).all.page(params[:page]).per(20)
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
ends