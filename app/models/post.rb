class Post < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :image

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  validates :image, {
    presence: true
  }

  def get_most_recent_likes
    self.likes.order("created_at DESC").limit(LIKES_LIMIT)
  end

  def get_image_url
    url_for(self.image)
  end

  def liked_by?(user)
    self.likers.include?(user)
  end
  
end
