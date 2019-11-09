require "rails_helper"

class PostFactory

  def create(user_id: UserFactory.create().id, caption: createCaption(), image: getImage())
    Post.create(
      user_id: user_id,
      caption: caption,
      image: image
    )
  end

  def create_without_id(caption: createCaption(), image: getImage())
    Post.create(
      caption: caption,
      image: image
    )
  end

  def create_without_caption(user_id: UserFactory.create().id, image: getImage())
    Post.create(
      user_id: user_id,
      image: image
    )
  end

  def create_without_image(user_id: UserFactory.create().id, caption: createCaption())
    Post.create(
      user_id: user_id,
      caption: caption
    )
  end

  private def createCaption
    Faker::Lorem.sentence(word_count: 20)
  end

  private def getImage
    image_path = "#{::Rails.root}/storage/defaults/default_post_image.png"
    return {
      io: File.open(image_path),
      filename: "default_post_image.png",
      content_type: "image/png"
    }
  end

end