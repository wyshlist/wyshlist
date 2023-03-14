# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Cleaning database..."
User.destroy_all
Wishlist.destroy_all
Wish.destroy_all
Vote.destroy_all
Comment.destroy_all
Organization.destroy_all
puts "Creating main sample user..."
# Create a main sample user.
organization = Organization.create(name: "Le Wagon")
user = User.create!(email: "user1@gmail.com", password: "123123", username: "user1", organization: organization)

# Generate a bunch of additional users.
99.times do |n|
    name = Faker::Name.name
    email = Faker::Internet.email
    password = "123123"
    User.create!(email: email, password: password, username: name)
    print "*"
end
puts "Creating main sample wishlist..."
# Create a main sample wishlist.
Wishlist.create!(title: "Wishlist 1", description: "This is the first wishlist.", user: user)
puts ""
puts "Creating main sample wish..."
# Generate a bunch of additional wishlists.
99.times do |n|
    print "*"
    title = Faker::Lorem.sentence(word_count: 3)
    description = Faker::Lorem.sentence(word_count: 10)
    Wishlist.create!(title: title, description: description, user: User.all.sample, color: Wishlist::COLOR.sample)
end
puts ""
puts "Creating main sample wish..."
# Generate a bunch of additional wishes.
99.times do |n|
    print "*"
    title = Faker::Lorem.sentence(word_count: 3)
    description = Faker::Lorem.sentence(word_count: 10)
    Wish.create!(title: title, description: description, wishlist: Wishlist.all.sample, user: User.all.sample)
end

# Create a main sample vote.
puts ""
puts "Creating main sample vote..."
# Generate a bunch of additional votes.
User.all.each do |user|
    print "*"
    Vote.create!(user: user, wish: Wish.all.sample)
end
puts ""
puts "Creating main sample comment..."
# Generate a bunch of additional comments.
99.times do |n|
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

