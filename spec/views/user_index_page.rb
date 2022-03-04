require 'rails_helper'
require 'capybara/rspec'

describe 'User index page', type: :feature do
  context 'when successful' do
    before :each do
      @user1 = User.new(name: 'Rafael', bio: 'Rafael bio',
                        photo: 'https://avatars.githubusercontent.com/u/53021807?v=4', email: 'rafael@test.com', password: '123456')
      @user1.save
      user2 = User.new(name: 'Promise', bio: 'Promise bio',
                       photo: 'https://avatars.githubusercontent.com/u/46839548?v=4', email: 'promise@test.com', password: '123456')
      user2.save
    end

    it 'I can see the name of all users' do
      visit 'users'
      expect(page).to have_content('Rafael')
      expect(page).to have_content('Promise')
    end

    it 'I can see the photo(Link) of all users' do
      visit 'users'
      expect(page).to have_css("img[src*='https://avatars.githubusercontent.com/u/53021807?v=4']")
      expect(page).to have_css("img[src*='https://avatars.githubusercontent.com/u/46839548?v=4']")
    end

    it 'I can see the number of post of all users (Everybody have 0, these are recently created users)' do
      visit 'users'
      expect(page).to have_content('Number of posts: 0')
    end

    it 'When I click on a user button, I am redirected to that user show page.' do
      visit 'users'
      click_link('Rafael')
      expect(current_path).to eq("/users/#{@user1.id}")
    end
  end
end
