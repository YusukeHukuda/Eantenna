class Public::CommentsController < ApplicationController
  
    def create
      post = Post.find(params[:post_id])
      comment = current_user.comments.new(comment_params)
      comment.post_id = post.id
      comment.save
      redirect_back(fallback_location: root_path)  #コメント送信後は、一つ前のページへリダイレクトさせる。
    end
    


    private
  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end
