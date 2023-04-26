class Public::UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
  end

  def edit
  end

  def unsubscribe
  end
end
