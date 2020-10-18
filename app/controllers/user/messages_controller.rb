class User::MessagesController < ApplicationController
  before_action :logged_in_user
  
  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
      @message = current_user.messages.create!(message_params)
      # @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(:user_id => current_user.id))
      # redirect_to "/rooms/#{@message.room_id}"
      # 投稿されたメッセージをチャット参加者に配信
      ActionCable.server.broadcast 'room_channel', message: @message.template
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def message_params
    params.require(:message).permit(:content, :user_id, :room_id)
  end
end