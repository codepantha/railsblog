class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.new(post_params)
    @post.user = @user
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.valid?
      @post.save!
      redirect_to user_post_url({ user_id: @user.id, id: @post.id })
      flash[:success] = 'Post created successfully'
    else
      errors = @post.errors
      # get the full message of the error
      flash[:notice] = errors.full_messages.join("\n")
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
