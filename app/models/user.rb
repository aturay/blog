class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  belongs_to :ip
end
