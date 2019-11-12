require "faker"

def create_user(name: Faker::Name.first_name, username: Faker::Internet.username(specifier: 4..30), email: Faker::Internet.email, password: "password1^")
  User.create(
    name: name,
    username: username,
    email: email,
    password: password
  )
end

def create_post(user_id: create_user().id, caption: Faker::Lorem.sentence(word_count: 20), image: getImage())
  Post.create(
    user_id: user_id,
    caption: caption,
    image: image
  )
end

def getImage
  image_path = "#{::Rails.root}/storage/defaults/default_post_image.png"
  return {
    io: File.open(image_path),
    filename: "default_post_image.png",
    content_type: "image/png"
  }
end

10.times { create_user() }

User.all.each() do |user|
  3.times { create_post(user_id: user.id) }
  5.times do 
    user_to_follow = User.all.sample
    unless user.followed.include?(user_to_follow)
      user.followed << user_to_follow
    end
  end
  user.save()
end

