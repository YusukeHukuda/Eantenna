class Public::UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
    @posts = @user.posts.page(params[:page]).per(10)
    @tag_lists = Tag.all
  end

  def edit
  end

  def unsubscribe
  end
end
