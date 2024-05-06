class GroupsController < ApplicationController
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to users_path
    else
      render "new"
    end
  end
  
  def index
    
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
