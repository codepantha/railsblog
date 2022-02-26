class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comments

  after_save :update_user_posts_counter

  validates :title, presence: true
  validates :title, length: { maximum: 250, message: 'Title must not exceed 250 characters' }
  validates :comments_counter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
                            message: 'comments_counter must be greater than or equal to 0' }
  validates :likes_counter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
                            message: 'likes_counter must be greater than or equal to 0' }

  private

  # update a user's posts_counter
  def update_user_posts_counter
    user.update(posts_counter: user.posts.count)
  end

  # get 5 of the most recent comments
  def latest_five_comments
    comments.order(created_at: :desc).limit(5)
  end
end
