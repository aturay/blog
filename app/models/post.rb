class Post < ApplicationRecord
  has_many :ratings
  belongs_to :user
  belongs_to :ip

  # Get top posts
  scope :top_posts, -> { 
    select('title, content, AVG(ratings.num) AS average')
    .joins(:ratings)
    .group(:id)
    .order('average DESC')
  }

end
