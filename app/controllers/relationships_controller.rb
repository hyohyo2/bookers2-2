class RelationshipsController < ApplicationController
  
  def create
    user = User.find(params[:user_id])
    follower = current_user.followers.new(follower_id)
    follower.save
    redirect_back(fallback_location: root_path)
    followed = current_user.followeds.new(followed_id)
    followed.save
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    user = User.find(params[:user_id])
    follower = current_user.followers.find_by(follower_id)
    follower.destroy
    redirect_back(fallback_location: root_path)
    followed = current_user.followed.find_by(followed_id)
    followed.destroy
    redirect_back(fallback_location: root_path)
  end
  
end
