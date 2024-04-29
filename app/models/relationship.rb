class Relationship < ApplicationRecord

  belongs_to :follower, class_name:"User", foreign_key: "follower_id"
  belongs_to :followed, class_name:"User", foreign_key: "followed_id"

  validates :user_id, uniqueness: {scope: [:follower_id, :followed_id]}

end
