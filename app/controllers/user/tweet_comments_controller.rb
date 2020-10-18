class User::TweetCommentsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy]

  def create
    @tweet = Tweet.find(params[:id])
    @tweet_comment = @tweet.tweet_comments.build(tweet_comment_params)
    @tweet_comment.user_id = current_user.id
    @tweet_comment.tweet_id = @tweet.id
    if @tweet_comment.save
      flash[:success] = "ツブヤキにコメントしました!"
      redirect_to request.referer
    else
      flash[:warning] = "コメントに失敗しました、140文字以内でコメントをしてください。"
      @tweet = Tweet.find(params[:id])
      @tweet_comments = @tweet.tweet_comments.all
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
      render 'user/tweets/show'
    end
  end
  
  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @tweet_comment = TweetComment.find(params[:id])
    if @tweet_comment.destroy
      flash[:info] = "コメントを削除しました"
      redirect_to request.referer
    else
      flash[:danger] = "コメントを削除できませんでした"
      redirect_to request.referer
    end
  end
  
  def correct_user
    @tweet_comment = TweetComment.find(params[:id])
  end
  
    private
      def tweet_comment_params
        params.require(:tweet_comment).permit(:content)
      end
end