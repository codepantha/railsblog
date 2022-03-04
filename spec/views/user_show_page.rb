require 'rails_helper'
require 'capybara/rspec'

describe 'User profile page', type: :feature do
  before :each do
    @user = User.create(name: 'Rafael', bio: 'This is my life',
                        photo: 'https://avatars.githubusercontent.com/u/53021807?v=4',
                        email: 'rafael@test.com', password: '123456')

    @post1 = Post.create(user_id: @user.id, title: 'First Blog Post', text: 'This is a test 1')
    Post.create(user_id: @user.id, title: 'Second Blog Post', text: 'This is a test 2')
    Post.create(user_id: @user.id, title: 'Third Blog Post', text: 'This is a test 3')
  end

  it 'sees the user\'s profile pic' do
    visit "/users/#{@user.id}"
    expect(page).to have_css("img[src*='https://avatars.githubusercontent.com/u/53021807?v=4']");
  end

  it 'sees the user\'s username' do
    visit "/users/#{@user.id}"
    expect(page).to have_content('Rafael')
  end

  it 'sees the total number user\'s posts' do
    visit "/users/#{@user.id}"
    expect(page).to have_selector(:id, 'posts_num', text: "Number of posts: #{@user.posts_counter}")
  end

  it 'sees the user\'s bio' do
    visit "/users/#{@user.id}"
    expect(page).to have_content(@user.bio)
  end

  it 'sees the user\'s last 3 posts' do
    visit "/users/#{@user.id}"
    expect(@user.last_three_posts.length).to eq(3)
  end

  it 'sees a button that lets me view all the user\'s posts' do
    visit "/users/#{@user.id}"
    expect(page).to have_button("See all posts")
  end

  it 'takes me to the show page when I click a post' do
    visit "/users/#{@user.id}"
    click_link "#{@post1.title}"
    expect(current_path).to eq("/users/#{@user.id}/posts/#{@post1.id}}")
  end

  it 'takes me to the user\'s posts index page when I click \'see all posts\'' do
    visit "/users/#{@user.id}"
    click_link "See all posts"
    expect(current_path).to eq("/users/#{@user.id}/posts")
  end
end