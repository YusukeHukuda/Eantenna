class Admin::PostsController < ApplicationController
before_action :authenticate_admin!

  def index
    @posts = Post.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @post_tags = @post.tags.pluck(:name).split(nil)
    @comments = @post.comments
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: "情報の変更の保存に成功しました"
    else
      render :edit
    end
  end

  private
    def post_params
       params.require(:post).permit(:title, :body, :tag_list, :image, :tag_id, :user_id, :name, :address)
    end
    
    def comment_params
        params.require(:comment).permit(:comment_content)
    end
end
