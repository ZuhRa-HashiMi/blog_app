class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :posts
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_counters
  def update_counters
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  def most_recent_comments
    comments.limit(5).order(created_at: :desc)
  end
end
