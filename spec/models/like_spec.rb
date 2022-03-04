require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) do
    User.create!(name: 'Prom', bio: 'This is my life',
                 photo: 'https://avatars.githubusercontent.com/u/46839548?v=4',
                 email: 'prom@test.com', password: '123456')
  end
  let(:post) do
    Post.create!(user: user, title: 'The thorns of love', text: 'A song by Ocean Hart', comments_counter: 0,
                 likes_counter: 0)
  end

  it 'update likes counter for post' do
    post.likes.create(user: user)
    expect(post.likes.count).to eq(1)
  end
end
