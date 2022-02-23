class BlogEntriesController < ApplicationController
  def index
    @users = User.all
  end
end
