class Rating < ApplicationRecord
  belongs_to :post

  scope :rating, ->(id) { where('post_id' => id).average(:num) }
end
