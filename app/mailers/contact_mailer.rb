class ContactMailer < ApplicationMailer
  
  def send_notification(member, event)
    @group = event[:group]
    @title = event[:title]
    @body = event[:body]
   
  # メールの新規作成
   @mail = ContactMailer.new()
   mail(
     from: ENV['メールアドレス'],
     to: member.email,
     subject: 'New Event Notice!!'
     )
   
  end
  
  # メールをグループメンバーへ送信する
  def self.send_notifications_to_group(event)
    group = event[:group]
    # メンバーごとにメール作成
    group.users.each do |member|
      # eliver_nowで送信
      ContactMailer.send_notification(member, event).deliver_now
    end
  end
end
