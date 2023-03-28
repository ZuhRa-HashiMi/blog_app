require 'rails_helper'

RSpec.describe "Users", type: :system do
  fixtures :users
  let(:user1) { users(:one)}
  let(:user2) { users(:two)}
  let(:user3) { users(:three)}
  describe 'show page ' do 
    it 'I can see the users profile picture.' do
      visit users_path(user1)
      expect(page).to have_selector("img[src='#{user1.photo}']")
      visit users_path(user2)
      expect(page).to have_selector("img[src='#{user2.photo}']")
      visit users_path(user3)
      expect(page).to have_selector("img[src='#{user3.photo}']")
    end
  end
end
