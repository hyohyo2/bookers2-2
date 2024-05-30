class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  # Bookモデルに対して関連付けを増やす(１週間以内のいいね取得)
  has_many :week_favorites, -> { where(created_at: 1.week.ago.beginning_of_day..Time.current.end_of_day) }
  has_many :book_comments, dependent: :destroy
  
  # 閲覧数
  has_many :read_counts, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  scope :created_today, -> { where(created_at: Time.zone.now.all_day)}
    scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
    scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
    scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }
  
  # 前日投稿比
  def the_day_before
    ((today_book.count / yesterday_book.count ) * 100).floor
  end
  
  # 先週投稿数比
  def the_week_before
    ((this_week_book.count / last_week_book.count ) * 100).floor
  end
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?

  end

  # book検索方法分岐
  def self.search_for(search, word)
    if search == 'perfect'
       Book.where(title: word)
    elsif search == 'forward'
     Book.where('title LIKE?', word + '%' )
    elsif search == 'backward'
      Book.where('title LIKE?', '%' + word )
    else
      Book.where("title LIKE?", '%' + word + '%' )
    end
  end
end
