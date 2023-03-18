class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  after_save :update_post_counter
  after_destroy :update_post_counter
  def update_post_counter
    author.update(post_count: author.posts.count)
  end

  def get_recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
