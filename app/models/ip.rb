class Ip < ApplicationRecord
  has_many :users
  has_many :posts


  # Get ip lists
  def self.lists_ip
    eager_load(:users).map do |ip|
      next if ip.users.count <= 1
      
      { ip: ip.ip, users: ip.users.map(&:login) }
    end
  end
end
