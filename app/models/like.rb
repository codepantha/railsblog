class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.update_post_likes_counter(post)
    post.update(likes_counter: post.likes.count)
  end
end
