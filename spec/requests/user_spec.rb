require 'rails_helper'

RSpec.describe 'User', type: :request do
  describe 'GET /index' do
    it 'renders the index template' do
      get users_path
      expect(response).to render_template('index')
    end
  end

  describe 'GET /show' do
    let(:user) { User.create!(name: 'Alice', posts_counter: 0) }
    it 'renders the show template' do
      get user_path(user)
      expect(response).to render_template('show')
    end
  end
end
