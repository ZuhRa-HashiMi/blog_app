require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }

  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'most_recent_comments' do
    let!(:post) { Post.create!(title: 'My First Post', user:, text: 'Zuhra is a good girl', comments_counter: 0, likes_counter: 0) }
    let!(:comment1) { Comment.create!(post:, user:, text: 'First Comment') }
    let!(:comment2) { Comment.create!(post:, user:, text: 'Second Comment') }
    let!(:comment3) { Comment.create!(post:, user:, text: '3rd Comment') }
    let!(:comment4) { Comment.create!(post:, user:, text: 'fourth Comment') }
    let!(:comment5) { Comment.create!(post:, user:, text: 'fifth Comment') }
    let!(:comment6) { Comment.create!(post:, user:, text: 'sixth Comment') }

    it 'limits the number of most recent comments upto 5 for the post' do
      expect(post.most_recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
    end
  end

  describe 'update_posts_counter' do
    let!(:post) { Post.create!(title: 'My First Post', user:, text: 'Zuhra is a good girl', comments_counter: 0, likes_counter: 0) }

    it 'increments the user post counter after saving' do
      expect { post.save }.to change { user.reload.posts_counter }.by(1)
    end
  end
end
