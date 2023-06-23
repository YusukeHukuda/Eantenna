class Public::PostsController < ApplicationController
  before_action :require_login

  def new
    @post = Post.new
    @tag = @post.tags.new
    @tag_lists = Tag.all

    @header_text = "Let's post"
    @header_text_sub = "投稿ページです。あなたのemotionalを共有しましょう！"
  end

  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:name].split(nil)
    @post.user_id = current_user.id
    if  @post.save
        @post.save_posts(tag_list)
        redirect_to posts_path, notice: '投稿ありがとうございます'
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

    @header_text = "List of posts"
    @header_text_sub = "このページは投稿一覧です。みんなの投稿を観覧しましょう。投稿詳細はRead moreを押してください。"
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = current_user.comments.new
    @post_tags = @post.tags
    @tag_lists = Tag.all

    @header_text = "Post details"
    @header_text_sub = "このページは投稿詳細です。場所の確認、いいね、コメントができます。投稿の編集や削除はこのページから行えます。"
  end

  def edit
    @post = Post.find(params[:id])
    @post_tags = @post.tags.pluck(:name).split(nil)
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    post_tags =params[:post][:name].split(nil)

    if @post.update(post_params)
       @post.save_posts(post_tags)
       redirect_to post_path(@post), notice: "変更の保存に成功しました"
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
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
        params.require(:post).permit(:title, :body, :tag_list, :image, :tag_id, :user_id, :name, :address)
  end
