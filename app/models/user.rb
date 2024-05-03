class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # フォローしている関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id",dependent: :destroy
  # フォローされている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローしているユーザの取得
  has_many :followings, through: :active_relationships, source: :followed
  # フォローされているユーザの取得
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum:50 }
  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  # 指定ユーザーのフォロー
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end
  
  # 指定ユーザーのフォロー解除
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
    
  end
  
  # 指定ユーザのフォロー判定
  def following?(user)
    followings.include?(user)
    
  end
  
  # user検索方法分岐
  def self.search_for(search, word)
    if search == 'perfect'
      User.where(name: word)
    elsif search == 'forward'
       User.where('name LIKE?', word + '%')
    elsif search == 'backward'
       User.where("name LIKE?", '%' + word)
    else
       User.where('name LIKE?', '%' + word + '%' )
    end
  end  
end
