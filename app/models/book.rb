class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  # Bookモデルに対して関連付けを増やす(１週間以内のいいね取得)
  has_many :week_favorites, -> { where(created_at: 1.week.ago.beginning_of_day..Time.current.end_of_day) }
  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

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
