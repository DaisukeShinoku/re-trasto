class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "本登録が完了しました、trastoへようこそ!"
      redirect_to root_url
    else
      flash[:danger] = "無効なリンクです。お手数ですが再登録をお願いします。"
      redirect_to root_url
    end
  end
end
