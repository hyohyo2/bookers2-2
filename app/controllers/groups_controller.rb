class GroupsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path, method: :post
    else
      render "new"
    end
  end
  
  def index
    @groups = Group.all
    @book = Book.new
    @user = User.find(current_user.id)
    
  end
  
  def show
    @group = Group.find(params[:id])
    @book = Book.new
    @user = User.find(params[:id])
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  private
    def group_params
      params.require(:group).permit(:name, :introduction, :group_image)
    end
    
    def ensure_correct_user
      @group = Group.find(params[:id])
      unless @group.owner_od == current_user.id
        redirect_to groups_path
      end
    end
end
