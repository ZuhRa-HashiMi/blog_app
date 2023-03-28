require 'rails_helper'

RSpec.describe "Users", type: :system do
  fixtures :users
  let(:user1) { users(:one)}
  let(:user2) { users(:two)}
  let(:user3) { users(:three)}
  describe 'index page ' do 
    it 'I can see the user name of all other users.' do
      visit users_path
      expect(page).to have_content(user1.name)
      expect(page).to have_content(user2.name)
      expect(page).to have_content(user3.name)
    end

    it "I can see the profile picture of each user" do
      visit users_path
      expect(page).to have_selector("img[src='#{user1.photo}']")
      expect(page).to have_selector("img[src='#{user2.photo}']")
      expect(page).to have_selector("img[src='#{user3.photo}']")
    end
  end
end
