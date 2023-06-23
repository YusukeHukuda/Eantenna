class Public::UsersController < ApplicationController
  before_action :require_login

  def show
    @user = User.find(current_user.id)
    # @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
    @tag_lists = Tag.all
  end

  def favorite
    @user = User.find(current_user.id)
    # @user = User.find(params[:id])
    favorites = Like.where(user_id: @user.id).pluck(:post_id)
    @favorites_posts = Post.find(favorites)
    @tag_lists = Tag.all
  end

  def edit
    @user = User.find(current_user.id)
    @tag_lists = Tag.all
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "保存に成功しました。"
      redirect_to users_path

    else
      render :show
    end
  end

  def unsubscribe
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :self_introduction, :is_deleted, :profile_image)
  end
end
