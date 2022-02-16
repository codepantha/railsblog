require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'get base page' do
      get user_posts_path(user_id: 3)
      expect(response).to have_http_status(200)
      expect(response).to render_template('index')
      expect(response.body).to include('Show all posts belonging to a single user')
    end

    it 'get a specific blog of an user' do
      get user_post_path(user_id: 10, id: 1)
      expect(response).to have_http_status(200)
      expect(response.body).to include('My post 1')
      expect(response.body).to include('My post 2')
    end
  end
end
