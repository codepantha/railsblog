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
      render :new, flash: { error: 'Something went wrong with your post' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
