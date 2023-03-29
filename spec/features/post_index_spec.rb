require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  fixtures :users, :posts, :comments
  let(:user1) { users(:one) }
  describe 'Index page' do
    it "can see the user's profile picture." do
      visit user_posts_path(user1)
      expect(page).to have_selector("img[src='#{user1.photo}']")
    end
    it "can see the user's username." do
      visit user_posts_path(user1)
      expect(page).to have_content(user1.name)
    end
    it 'can see the number of posts the user has written.' do
      visit user_posts_path(user1)
      expect(page).to have_content(user1.posts_counter)
    end
    it "can see a post's title." do
      visit user_posts_path(user1)
      user1.posts.limit(3).each do |post|
        expect(page).to have_content(post.title)
      end
    end
    it "can see some of the post's body." do
      visit user_posts_path(user1)
      user1.posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end
    it 'can see the first comments on a post.' do
      visit user_posts_path(user1)
      post1 = user1.posts.first
      expect(page).to have_content(post1.comments.first.text)
    end
    it 'can see how many comments a post has.' do
      visit user_posts_path(user1)
      user1.posts.each do |post|
        expect(page).to have_content(post.comments_counter)
      end
    end
    it 'can see how many likes a post has.' do
      visit user_posts_path(user1)
      user1.posts.each do |post|
        expect(page).to have_content(post.likes_counter)
      end
    end
  end
end
