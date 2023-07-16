class Admin::PostsController < ApplicationController
before_action :authenticate_admin!

  def index
   @posts = Post.includes(:tags).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @post_tags = @post.tags.pluck(:name).split(nil)
    @comments = @post.comments
  end

  def update
    @post = Post.find(params[:id])
    post_tags =params[:post][:name].split(nil)

    if @post.update(post_params)
      @post.save_posts(post_tags)
      redirect_to admin_post_path(params[:id]), notice: "情報の変更の保存に成功しました"
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  private
    def post_params
       params.require(:post).permit(:title, :body, :tag_list, :image, :tag_id, :user_id, :name, :address)
    end

    # def comment_params
    #     params.require(:comment).permit(:comment_content)
    # end

    # def tag_params
    #   params.require(:tag).permit(:name)
    # end
end
