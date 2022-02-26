require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject do
    User.new(
      name: 'Codepantherr',
      photo: 'http://unsplash.com/codepantherr',
      bio: 'badass dev',
      posts_counter: 0
    )
  end

  before { subject.save }

  it 'name is required' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter is must be an integer and >= 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'last_three_posts should return return count 3' do
    subject.posts.create(title: 'test', text: 'test test test', comments_counter: 0, likes_counter: 0)
    subject.posts.create(title: 'test2', text: 'test test test', comments_counter: 0, likes_counter: 0)
    subject.posts.create(title: 'test3', text: 'test test test', comments_counter: 0, likes_counter: 0)
    subject.posts.create(title: 'test4', text: 'test test test', comments_counter: 0, likes_counter: 0)

    expect(subject.last_three_posts.length).to eq(3)
  end
end
