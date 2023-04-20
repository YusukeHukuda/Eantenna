class Public::PostsController < ApplicationController
   def create
    @post = Book.new(book_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to root_path(@book), notice: 'Book was successfully created.'
    else
      @posts = Post.all
      @user = User.find(current_user.id)
      render 'index'
    end
  end

  def index
  end

  def show
  end

  def edit
  end
end
