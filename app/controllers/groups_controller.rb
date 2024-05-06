class GroupsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path, method: :post
    else
      render "new"
    end
  end
  
  def index
    @book = Book.new
    @groups = Group.all
    @user = User.find(current_user.id)
    
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  private
    def group_params
      params.require(:group).permit(:name, :introduction, :group_image)
    end
  
end
