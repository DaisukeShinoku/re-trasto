class Admin::TweetsController < ApplicationController
  before_action :admin_user

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:danger] = "ツブヤキを削除しました"
    redirect_to admin_tweets_url
  end

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all.first(20)
  end

  def show
    @tweet = Tweet.find(params[:id])
    @tweet_comments = @tweet.tweet_comments.all
  end

end