class Public::UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
    @tag_lists = Tag.all
  end

  def edit
  end

  def unsubscribe
  end
end
