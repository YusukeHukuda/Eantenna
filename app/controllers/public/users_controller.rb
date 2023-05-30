class Public::UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
    # @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
    @tag_lists = Tag.all
  end

  def edit
  end

  def unsubscribe
  end
end
