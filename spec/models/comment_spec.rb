require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) do
    User.create!(name: 'Ocean Hart', photo: 'http://unsplash.com', email: 'prom@gmail.com', password: '123456',
                 bio: 'Musician', posts_counter: 0)
  end

  let(:post) do
    Post.create!(
      user: user,
      title: 'The zanga',
      text: 'The legend of the cage of the zanga',
      comments_counter: 0,
      likes_counter: 0
    )
  end

  it 'comment gets added to the post' do
    post.comments.create(user: user, text: 'This is a test comment')
    expect(post.comments.count).to eq(1)
  end
end
