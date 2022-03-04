require 'rails_helper'
require 'capybara/rspec'

describe 'Post Show Page', type: :feature do
  before :each do
    @user = User.create(name: 'Prom', bio: 'This is my life',
                        photo: 'https://avatars.githubusercontent.com/u/53021807?v=4',
                        email: 'rafael@test.com', password: '123456',
                        confirmed_at: '2022-03-02 22:25:13.71382')

    @post = @user.posts.create(title: 'The test', text: 'The only test', comments_counter: 0, likes_counter: 0)
    @comment = Comment.create(user: @user, post: @post, text: 'Nice post')
    Like.create(user: @user, post: @post)

    visit user_post_path(@user, @post)
  end

  it 'sees the post title' do
    expect(page).to have_selector(:id, 'post-title', text: @post.title)
  end

  it 'sees the post author' do
    expect(page).to have_content(@post.user.name)
  end

  it 'sees the comment count' do
    expect(page).to have_content("Comments: #{@post.comments.count}")
  end

  it 'sees the like count' do
    expect(page).to have_content("Likes: #{@post.likes_counter}")
  end

  it 'sees the post body' do
    expect(page).to have_content(@post.text)
  end

  it 'sees the username of each commentor' do
    expect(page).to have_selector(:id, 'comment', text: @user.name.to_s)
  end

  it 'sees the each commenter\'s comment' do
    expect(page).to have_content(@comment.text)
  end
end
