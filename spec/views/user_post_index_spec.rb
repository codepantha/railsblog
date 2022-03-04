require 'rails_helper'
require 'capybara/rspec'

describe 'User Posts Index Page', type: :feature do
  before :each do
    @user = User.create(name: 'Prom', bio: 'This is my life',
                        photo: 'https://avatars.githubusercontent.com/u/53021807?v=4',
                        email: 'rafael@test.com', password: '123456',
                        confirmed_at: '2022-03-02 22:25:13.71382')

    @post = @user.posts.create(title: 'The test', text: 'The only test', comments_counter: 0, likes_counter: 0)
    @comment = Comment.create(user: @user, post: @post, text: 'Nice post')

    visit user_posts_path(@user)
  end

  it 'sees the user\'s profile pic' do
    expect(page).to have_css("img[src*='https://avatars.githubusercontent.com/u/53021807?v=4']")
  end

  it 'sees the  user\'s username' do
    expect(page).to have_content(@user.name)
  end

  it 'sees the total number of user\'s posts' do
    expect(page).to have_selector(:id, 'posts_num', text: "Number of posts: #{@user.posts.count}")
  end

  it 'sees the post title' do
    expect(page).to have_selector(:id, 'post-title', text: @post.title)
  end

  it 'sees the post body' do
    expect(page).to have_content(@post.text[0, 50])
  end

  it 'sees the first comment' do
    p @post.comments.first
    expect(page).to have_content(@comment.text)
  end

  it 'sees how many comments a post has' do
    expect(@post.comments.count).to eq(1)
  end

  it 'sees how many likes it has' do
    Like.create(user: @user, post: @post)
    expect(@post.likes.count).to eq(1)
  end

  it 'sees pagination button' do
    expect(page).to have_button('Pagination')
  end

  it 'redirects me to the post show page when I click on a post' do
    click_link @post.title.to_s
    expect(current_path).to eq(user_post_path(@user, @post))
  end
end
