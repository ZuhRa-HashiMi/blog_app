class User < ApplicationRecord
  has_many :Posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id
  def get_recent_post(limit = 3)
    posts.order(create_at: :desc).limit(limit)
  end
end
