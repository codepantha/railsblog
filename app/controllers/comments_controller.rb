class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])

    @comment = Comment.new(user: @user, post: @post, text: params[:comment][:text])
    if @comment.save
      redirect_to user_post_url({ user_id: @user.id, id: @post.id })
      flash[:success] = 'Comment created successfully'
    else
      render :new, flash: { error: 'Something went wrong with your post' }
    end
  end
end
