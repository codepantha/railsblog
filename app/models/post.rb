class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comments

  # update a user's posts_counter
  def self.update_user_posts_counter(user)
    user.update(posts_counter: user.posts.count)
  end

  # get 5 of the most recent comments
  def latest_five_comments
    comments.order(created_at: :desc).limit(5)
  end
end
