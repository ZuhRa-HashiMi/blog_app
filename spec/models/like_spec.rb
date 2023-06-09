require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:post) }
  end

  describe 'update_post_likes_counter' do
    let!(:user) { User.create!(name: 'John Doe', posts_counter: 0) }
    let!(:post) { Post.create!(title: 'My First Post', user:, text: 'this is my first post', comments_counter: 0, likes_counter: 0) }
    let!(:like) { Like.new(user:, post:) }

    it 'increments the post likes counter after saving' do
      expect { like.save }.to change { post.reload.likes_counter }.by(1)
    end
  end
end
