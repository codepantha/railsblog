class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.update_post_comments_counter(post)
    post.update(comments_counter: post.comments.count)
  end
end
