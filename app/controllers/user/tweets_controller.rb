class User::TweetsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: :destroy

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:success] = "ツブヤキしました!"
      redirect_to tweets_url
    else
      flash.now[:warning] = "ツブヤキに失敗しました、140文字以内でツブヤキをしてください。"
      @tweets = Tweet.all.page(params[:page]).per(20)
      @user = current_user
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
      render action: :index
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:danger] = "ツブヤキを削除しました"
    redirect_to request.referrer || root_url
  end

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all.page(params[:page]).per(20)
    @user = current_user
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

  def show
    @tweet = Tweet.find(params[:id])
    @tweet_comments = @tweet.tweet_comments.all.page(params[:page]).per(20)
    @tweet_comment = TweetComment.new
    @user = @tweet.user
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

    def tweet_params
      params.require(:tweet).permit(:content, :tweet_picture)
    end

    def correct_user
      @tweet = current_user.tweets.find_by(id: params[:id])
      redirect_to root_url if @tweet.nil?
    end
end