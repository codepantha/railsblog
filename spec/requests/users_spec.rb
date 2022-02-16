require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it "get a user's page" do
      get user_path(id: 3)
      expect(response).to have_http_status(200)
      expect(response.body).to include('Single User')
    end

    it 'requesting to the /users path should also return the index' do
      get '/users'
      expect(response).to have_http_status(200)
      expect(response).to render_template('index')
    end
  end
end
