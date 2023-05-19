class Public::PostsController < ApplicationController

  def new
    @post = Post.new
    @tag = @post.tags.new
    @tag_lists = Tag.all
  end

  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:name].split(nil)
    @post.user_id = current_user.id
    if  @post.save!
        @post.save_posts(tag_list)
        redirect_to posts_path, notice: 'created.'
    else
      flash.now[:alert] = '投稿に失敗しました'
      render 'new'
    end
  end

  def index
    if params[:search].present?
      posts = Post.posts_serach(params[:search])
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      posts = @tag.posts.order(created_at: :desc)
    else
      posts = Post.all.order(created_at: :desc)
    end
    @tag_lists = Tag.all
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = current_user.comments.new
    @post_tags = @post.tags
    @tag_lists = Tag.all
    # @user = User.find(params[:id])
  end

  def edit
  end

  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @posts = Post.search(params[:keyword])
    @keyword = params[:keyword]
    render "search"
  end

end

private

  def post_params
        params.require(:post).permit(:title, :body, :tag_list, :image, :latitude, :longitude, :tag_id, :user_id, :name, :address)
  end
