require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:post) }
  end

  describe 'update_post_likes_counter' do
    let!(:user) { User.create!(name: 'John Doe', posts_counter: 0) }
    let!(:post) { Post.create!(title: 'My First Post', user:, text: 'My second text', comments_counter: 0, likes_counter: 0) }
    let!(:comment) { Comment.new(user:, post:) }

    it 'increments the post comment counter after saving' do
      expect { comment.save }.to change { post.reload.comments_counter }.by(1)
    end
  end
end
