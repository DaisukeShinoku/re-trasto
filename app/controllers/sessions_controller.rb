class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:info] = 'ログインしました'
        redirect_back_or root_url
      else
        message  = "アカウントが有効化されていません。"
        message += "送信したメールのリンクからアカウントの有効化をお願いします。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:warning] = 'メールアドレスかパスワードが正しくありません'
      render action: :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:info] = 'ログアウトしました'
    redirect_to root_url
  end

  def new_guest
    user = User.find_by(email: "guest@trasto.com")
    log_in user
    flash[:info] = 'ゲストユーザーとしてログインしました。'
    redirect_to root_path
  end
end
