# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

# Create a default user
# check if user is existing
user = User.find_or_initialize_by(email: 'admin@example.com')

if user.persisted?
  puts 'User already exists'
else
  user.display_name = 'Admin User'
  user.username = 'admin'
  user.password = 'password'
  user.save!
  puts 'Default user created!'
end

