require "./UserFactory"

class PostFactory

  USER = UserFactory.create
  CAPTION = "Test caption"

  private def self.create(user_id: USER.id, caption: CAPTION, image: self.createImage())
    Post.create(
      user_id: user_id,
      caption: caption,
      image: image
    )
  end

  private def self.createImage
    image_path = "#{::Rails.root}/storage/defaults/default_post_image.png"
    return { 
      io: File.open(image_path),
      filename: "default_post_image.png",
      content_type: "image/png"
    }
  end


end