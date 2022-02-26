require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    Post.new(
      user_id: 1,
      title: 'The zanga',
      text: 'The legend of the cage of the zanga',
      comments_counter: 0,
      likes_counter: 0
    )
  end

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title must not exceed 250 chars' do
    subject.title = 'com' * 260
    expect(subject).to_not be_valid
  end

  it 'comments counter must be an integer greater or equal to 0' do
    subject.comments_counter = nil
    expect(subject).to_not be_valid
  end

  it 'likes counter must be an integer greater or equal to 0' do
    subject.likes_counter = nil
    expect(subject).to_not be_valid
  end
end
