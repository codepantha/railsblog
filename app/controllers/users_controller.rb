class UsersController < ApplicationController
  def index
    @users = User.all
    render 'blog_entries/index'
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end
end
