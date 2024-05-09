class EventNoticesController < ApplicationController
  def new
    # フォームでグループIDが必要
    @group = Group.find(params[:group_id])

  end

  def create
    # フォーム入力の内容
    @group = Group.find(params[:group_id])
    @title= params[:title]
    @body = params[:body]

    # インスタンス変数のデータを変数evemtのハッシュとして登録
    # event[:group]→@groupを呼び出せる
    event = {
      # キー　=>　データ
      :group => @group,
      :title => @title,
      :body => @body
    }

    ContactMailer.send_notifications_to_group(event)
    render :sent
  end

  def sent
    redirect_to group_path(params[:group_id])
  end

end
