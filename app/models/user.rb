class User < ApplicationRecord
  include ValidationRegexps

  has_one_attached :avatar
  has_many :follows_as_followed, foreign_key: :followed_id, class_name: :Follow, dependent: :destroy
  has_many :follows_as_follower, foreign_key: :follower_id, class_name: :Follow, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_secure_password

  validates :name, :username, :email, :password, {
    presence: true
  }

  validates :name, {
    format: NAME_REGEX
  }

  validates :username, {
    uniqueness: true,
    format: USERNAME_REGEX
  }

  before_save :format_name

  private def format_name
    lowercase_name = self.name.downcase()
    capitalized_words = lowercase_name.split(" ").map() do |word|
      word.capitalize()
    end
    self.name = capitalized_words.join(" ")
  end


end