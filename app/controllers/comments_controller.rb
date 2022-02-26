class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])

    @comment = Comment.new(comment_params)
    @comment.user = @user
    @comment.post = @post

    if @comment.save
      redirect_to user_post_url({ user_id: @user.id, id: @post.id })
      flash[:success] = 'Comment created successfully'
    else
      errors = @post.errors
      # get the full message of the error
      flash[:notice] = errors.full_messages.join("\n")
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
