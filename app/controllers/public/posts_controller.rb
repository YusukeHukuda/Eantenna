class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save!
      redirect_to root_path, notice: 'created.'
    else
      @posts = Post.all
      render 'index'
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:id])
  end

  def edit
  end

  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @keyword = params[:post][:search] if params[:post]
    @posts_all = Post.search(@keyword)
    @posts = Kaminari.paginate_array(@posts_all).page(params[:page]).per(10)
  end

end

private

  def post_params
        params.require(:post).permit(:title, :body, :tag_list, :image, :latitude, :longitude)
  end
