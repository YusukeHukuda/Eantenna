class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(current_user.id)
    # @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
    @tag_lists = Tag.all

    @header_text = "Your profile"
    @header_text_sub = ""
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

    @header_text = "Edit profile"
    @header_text_sub = ""
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
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.is_deleted = true
    @user.save
    reset_session

    redirect_to root_path
    flash[:notice] = "退会処理を実行いたしました"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :self_introduction, :is_deleted, :profile_image)
  end
end
