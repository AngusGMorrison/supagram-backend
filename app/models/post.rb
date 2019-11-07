class Post < ApplicationRecord

  has_one_attached :photo

  belongs_to :user
  has_many :likes, dependent: :destroy
  
end
