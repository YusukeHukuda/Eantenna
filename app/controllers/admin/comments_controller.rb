class Admin::CommentsController < ApplicationController
  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to admin_post_path(@comment.post), notice: "Comment updated successfully."
    else
      render :edit
    end
  end

  def destroy
    # @post = Post.find(params[:id])  # コントローラでpostを取得する
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    redirect_to admin_post_path(@post), notice: "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end
