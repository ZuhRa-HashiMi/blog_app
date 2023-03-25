class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_counters
  def update_counters
    author.update(posts_counter: author.posts.count)
  end

  def most_recent_comments
    comments.limit(5).order(created_at: :desc)
  end
end
