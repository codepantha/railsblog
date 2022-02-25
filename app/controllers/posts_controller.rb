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
    @post = Post.new(user: @user, title: params[:post][:title], text: params[:post][:text])
    if @post.save
      redirect_to user_post_url({ user_id: @user.id, id: @post.id })
      flash[:success] = 'Post created successfully'
    else
      render :new, flash: { error: 'Something went wrong with your post' }
    end
  end
end
