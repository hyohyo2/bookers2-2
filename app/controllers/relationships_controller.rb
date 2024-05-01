class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    follower = current_user.followers.new(user_id: user.id)
    follower.save
    redirect_back(fallback_location: root_path)
    followed = current_user.followeds.new(user_id: user.id)
    followed.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = User.find(params[:user_id])
    follower = current_user.followers.find_by(follower_id: user.id)
    follower.destroy
    redirect_back(fallback_location: root_path)
    followed = current_user.followed.find_by(followed_id: user.id)
    followed.destroy
    redirect_back(fallback_location: root_path)
  end
  
 

end
