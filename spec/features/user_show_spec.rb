require 'rails_helper'

RSpec.describe "Users", type: :system do
  fixtures :users
  let(:user1) { users(:one)}
  let(:user2) { users(:two)}
  let(:user3) { users(:three)}
  describe 'show page ' do 
    it 'I can see the users profile picture.' do
      visit user_path(user1)
      expect(page).to have_selector("img[src='#{user1.photo}']")
      visit user_path(user2)
      expect(page).to have_selector("img[src='#{user2.photo}']")
      visit user_path(user3)
      expect(page).to have_selector("img[src='#{user3.photo}']")
    end

    it "I can see the user's username." do
      visit users_path(user1)
      expect(page).to have_content(user1.name)
      visit users_path(user2)
      expect(page).to have_content(user2.name)
      visit users_path(user3)
      expect(page).to have_content(user3.name)
    end

    it "I can see the number of posts the user has written." do
      visit user_path(user1)
      expect(page).to have_content(user1.posts_counter)
      visit user_path(user2)
      expect(page).to have_content(user2.posts_counter)
      visit user_path(user3)
      expect(page).to have_content(user3.posts_counter)
    end

    it "can see the user's bio." do
      visit user_path(user1)
      expect(page).to have_content(user1.bio)
      visit user_path(user2)
      expect(page).to have_content(user2.bio)
      visit user_path(user3)
      expect(page).to have_content(user3.bio)
    end

    it "I can see the user's first 3 posts." do
      visit user_path(user1)
      user1.recent_posts.each do |post|
        expect(page).to have_content(page.text)
      end
    end

    it "can see a button that lets me view all of a user's posts." do
      visit user_path(user1)
      expect(page).to have_link('See all posts', href: user_posts_path(user1))
    end

    it "When I click a user's post, it redirects me to that post's show page." do
      visit user_posts_path(user1)
      user1.posts.limit(3).each do |post|
        click_link "Post##{post.id}"
        expect(page).to have_current_path(user_post_path(user1, post))
        expect(page).to have_content(post.text)
        visit user_posts_path(user1)
      end
  end
end
