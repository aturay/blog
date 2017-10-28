# == Schema Information
#
# Table name: ratings
#
#  id      :integer          not null, primary key
#  num     :integer
#  post_id :integer
#

class Rating < ApplicationRecord
  belongs_to :post

  scope :rating, ->(id) { where('post_id' => id).average(:num) }
end
