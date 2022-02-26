class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
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
      @post.save
      redirect_to user_post_url({ user_id: @user.id, id: @post.id })
      flash[:success] = 'Post created successfully'
    else
      render :new
      flash.now[:notice] = 'Something went wrong with your post'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
