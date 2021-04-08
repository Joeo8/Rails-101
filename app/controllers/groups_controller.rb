class GroupsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :join, :quit]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    # @posts = @group.posts
    # 文章按发表时间倒序排列
    # @posts = @group.posts.order("created_at DESC")
    # 利用内建的scope实现排序功能（model中定义的recent）
    # @posts = @group.posts.recent
    # 添加文章分页展示功能
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
    # find_group_and_check_permission
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save
      redirect_to groups_path, notice: " Create Success " # 重定向到index列表
    else
      render :new
    end

  end

  def update
    # find_group_and_check_permission

    if @group.update(group_params)
      redirect_to groups_path, notice: " Update Success "
    else
      render :edit
    end
  end

  def destroy
    # find_group_and_check_permission

    @group.destroy
    flash[:warning] = "Group Deleted Success"
    redirect_to groups_path
  end

  def join
    @group = Group.find(params[:id])
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "加入本讨论版成功"
    else
      flash[:warning] = "您已经是本讨论版成员了"
    end
    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "已退出本讨论版"
    else
      flash[:warning] = "您不属于本讨论版"
    end
    redirect_to group_path(@group)
  end

  private

  def find_group_and_check_permission
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path, alert: " You have no permission "
    end
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
