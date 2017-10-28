# == Schema Information
#
# Table name: posts
#
#  id      :integer          not null, primary key
#  title   :string
#  content :text
#  user_id :integer
#  ip_id   :integer
#

class Post < ApplicationRecord
  has_many :ratings, dependent: :destroy
  belongs_to :user
  belongs_to :ip

  # Get top posts
  scope :top_posts, ->(n=10) {
    select('title, content, AVG(ratings.num) AS average')
    .joins(:ratings)
    .group(:id)
    .order('average DESC')
    .limit n
  }

end
