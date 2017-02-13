class Post < ApplicationRecord
  has_many :ratings
  belongs_to :user
  belongs_to :ip
end
