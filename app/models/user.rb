# == Schema Information
#
# Table name: users
#
#  id    :integer          not null, primary key
#  login :string
#  ip_id :integer
#

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  belongs_to :ip
end
