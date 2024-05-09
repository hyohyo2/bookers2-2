class ChatsController < ApplicationController
  before_action :block_non_related_users, only: [:show]
  
  def show
    @user = User.find(params[:id])
    rooms =current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    
    unless user_rooms.nil?
      # 共有チャットルームが存在する場合
      @room = user_rooms.room
    else
      # 共有チャットルームが存在しない場合
      @room = Room.new
      @room.save
      # チャットルームに現ユーザと相手ユーザを追加
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end
  
  def create
    @chat = current_user.chats.new(chat_params)
    render :validate unless @chat.save
  end
  
  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
  end
  
  private
  
    def chat_params
      params.require(:chat).permit(:message, :room_id)
    end
  
    #関連のないユーザをブロック
    def block_non_related_users
      user = User.find(params[:id])
      #相互フォーローか確認、していない場合はリダイレクト
      unless current_user.following?(user) && user.following?(current_user)
        redirect_to books_path
      end
    end
end
