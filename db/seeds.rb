# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Cleaning database..."
Vote.destroy_all
Comment.destroy_all
Wish.destroy_all
Wishlist.destroy_all
Organization.destroy_all
User.destroy_all

puts "Creating main sample user..."
# Create a main sample user.
organization = Organization.create(name: "Le Wagon", subdomain: "lewagon")
user = User.create!(
  email: "daniel@gmail.com",
  password: "123123",
  username: "daniel",
  organization:,
  role: "super_team_member",
  first_name: "Daniel",
  last_name: "Rodriguez"
)
User.create!(
  email: "alex@gmail.com",
  password: "123123",
  username: "alex",
  organization:,
  role: "team_member",
  first_name: "Alex",
  last_name: "Gorina"
)
User.create!(
  email: "christina@gmail.com",
  password: "123123",
  username: "christina",
  role: "user",
  first_name: "Christina",
  last_name: "Ali"
)

# Generate a bunch of additional users.
10.times do
  full_name = Faker::Name.name.split
  first_name = full_name.first
  last_name = full_name.last
  email = "#{first_name}@gmail.com"
  password = "123123"
  User.create!(email:, password:, first_name:, last_name:, username: "#{first_name}_#{last_name}")
  print "*"
end

# Create a main sample wishlist.
puts "Creating main sample wishlist..."
Wishlist.create!(
  title: "Wishlist 1",
  description: "This is the first wishlist.",
  user:,
  organization:,
  color: Wishlist::COLORS.sample
)

puts ""
# Generate a bunch of additional wishlists.
puts "Creating main sample wish..."
25.times do
  print "*"
  title = Faker::Lorem.sentence(word_count: 3)
  description = Faker::Lorem.sentence(word_count: 10)
  Wishlist.create!(
    title:,
    description:,
    user: User.all.sample,
    color: Wishlist::COLORS.sample,
    organization: Organization.all.sample
  )
end

puts ""
# Generate a bunch of additional wishes.
puts "Creating main sample wish..."
99.times do
  print "*"
  title = Faker::Lorem.sentence(word_count: 3)
  description = Faker::Lorem.sentence(word_count: 10)
  Wish.create!(
    title:,
    description:,
    wishlist: Wishlist.all.sample,
    user: User.all.sample,
    stage: Wish.stages.to_a.sample[1]
  )
end

puts ""
# Create a main sample vote.
puts "Creating main sample vote..."
# Generate a bunch of additional votes.
User.all.each do |vote_user|
  print "*"
  wishes = Wish.select { |wish| wish.user != vote_user }
  Vote.create!(user: vote_user, wish: wishes.sample)
end

puts ""
# Generate a bunch of additional comments.
puts "Creating main sample comment..."
99.times do
  print "*"
  body = Faker::Lorem.sentence(word_count: 10)
  Comment.create!(content: body, user: User.all.sample, wish: Wish.all.sample)
end

puts "Seeds completed!"
puts ". . . . . . . . . . .*. . . . . . . ** *
. . . . .. . . . . .*** . . * . . *****
. . . . . . . . . . .** . . **. . . . .*
. . . . . . . . . . ***.*. . *. . . . .*
. . . . . . . . . .****. . . .** . . . ******
. . . . . . . . . ***** . . . .**.*. . . . . **
. . . . . . . . .*****. . . . . **. . . . . . *.**
. . . . . . . .*****. . . . . .*. . . . . . *
. . . . . . . .******. . . . .*. . . . . *
. . . . . . . .******* . . .*. . . . .*
. . . . . . . . .*********. . . . . *
. . . . . . . . . .******* . ***
*******. . . . . . . . .**
.*******. . . . . . . . *
. ******. . . . . . . . * *
. .***. . *. . . . . . .**
. . . . . . .*. . . . . *
. . . . .****.*. . . .*
. . . *******. .*. .*
. . .*******. . . *.
. . .*****. . . . *
. . .**. . . . . .*
. . .*. . . . . . **.*
. . . . . . . . . **
. . . . . . . . .*
. . . . . . . . .*
. . . . . . . . .*
. . . . . . . . *
. . . . . . . . *
"
