class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :update_like_counter
  after_destroy :update_like_counter
  def update_like_counter
    post.update(like_count: post.likes.count)
  end
end
