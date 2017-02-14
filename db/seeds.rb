# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Variables
ips     = []
users   = []
posts   = []
ratings = []

ips_n     = 50
users_n   = 100
posts_n   = 200000


# Create ips
ips_n.times do |i|
  ips << Ip.new(ip: "192.168.0.#{i}")
end
Ip.import ips
puts "Created Ips: #{Ip.all.count}"

# Create users
users_n.times do |i|
  users << User.new(login: "login_#{i}", ip_id: rand(1..ips_n))
end
User.import users
puts "Created Users: #{Ip.all.count}"


# Create posts
posts_n.times do |i|
  posts << Post.new(title: "post_#{i}", content: "content", user_id: rand(1..users_n), ip_id: rand(1..ips_n))

  # Set rating post
  next unless i % 3 == 0
  rand(1..3).times do
    ratings << Rating.new(num: rand(1..5), post_id: rand(1..posts_n))
  end
end
Post.import posts
puts "Created Posts: #{Post.all.count}"

Rating.import ratings
puts "Created Ratings: #{Rating.all.count}"


# Create posts with http request
10.times do |i|
  uri = URI.parse("http://localhost:3000/set_post")
  param = { 'title' => "post_#{i}", 'content' => "content", 'user_login' => "login_#{rand(1..100)}", "ip" => "192.168.0.#{rand(1..49)}" }

  Net::HTTP.post_form(uri, param)

  # Set post rating
  next unless i % 5 == 0
  rand(1..5).times do
    uri = URI.parse("http://localhost:3000/set_rating")
    param = { 'num' => rand(1..5), 'post_id' => i }

    Net::HTTP.post_form(uri, param)
  end
end
