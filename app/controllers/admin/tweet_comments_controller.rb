class Admin::TweetCommentsController < ApplicationController
  before_action :admin_user

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @tweet_comment = TweetComment.find(params[:id])
    if @tweet_comment.destroy
      flash[:warning] = "コメントを削除しました"
      redirect_to request.referer
    else
      flash[:danger] = "コメントを削除できませんでした"
      redirect_to request.referer
    end
  end
  
end