class User < ApplicationRecord

  has_one_attached :avatar

  has_many :follows_as_followed, foreign_key: :followed_id, class_name: :Follow, dependent: :destroy
  has_many :follows_as_follower, foreign_key: :follower_id, class_name: :Follow, dependent: :destroy

  has_many :posts, dependent: :destroy

  has_many :likes, dependent: :destroy

end