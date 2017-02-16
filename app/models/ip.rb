class Ip < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :posts, dependent: :destroy


  # Get ip lists
  def self.lists_ip
    eager_load(:users).map do |ip|
      next if ip.users.count <= 1

      { ip: ip.ip, users: ip.users.map(&:login) }
    end
  end
end
