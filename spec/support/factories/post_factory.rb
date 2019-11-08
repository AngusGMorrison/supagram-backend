require "rails_helper"

class PostFactory

  CAPTION = Faker::Lorem.sentence(word_count: 20)
  IMAGE_PATH = "#{::Rails.root}/storage/defaults/default_post_image.png"
  IMAGE = {
    io: File.open(IMAGE_PATH),
    filename: "default_post_image.png",
    content_type: "image/png"
  }

  def self.create(user_id: UserFactory.create().id, caption: CAPTION, image: IMAGE)
    Post.create(
      user_id: user_id,
      caption: caption,
      image: image
    )
  end

end