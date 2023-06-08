class Public::UsersController < ApplicationController
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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(params[:id])
    else
      render :edit
    end
  end

  def unsubscribe
  end
end
