class Post < ApplicationRecord

  has_one_attached :image

  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :image, {
    presence: true
  }

  def get_most_recent_likes
    self.likes.order("created_at DESC").limit(LIKES_LIMIT)
  end
  
end
