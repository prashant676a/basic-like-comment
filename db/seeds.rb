# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#   
  10.times do |i|
    user = User.create(name:"User#{i+1}", email:"user#{i+1}@email.com", password:"#{i+1}"*6)
    user.posts.create(title:"Post Created by user #{i+1}", body: "Enjoy the post! ")
  end