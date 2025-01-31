10.times do |i|
  user = User.create(name:"User#{i+1}", email:"user#{i+1}@email.com", password:"#{i+1}"*6)
  user.posts.create(title:"Post Created by user #{i+1}", body: "Enjoy the post! ")
end
