class Post < ApplicationRecord

  has_one_attached :image

  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :user_id, :caption, :image, {
    presence: true
  }
  
end
