class User < ApplicationRecord
  include ValidationRegexps
  include ValidationErrorMessages

  has_one_attached :avatar
  has_many :followers, foreign_key: :followed_id, class_name: :Follow, dependent: :destroy
  has_many :followed, foreign_key: :follower_id, class_name: :Follow, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_secure_password

  validates :name, :username, :email, :password, {
    presence: true
  }

  validates :name, {
    format: NAME_REGEXP
  }

  validates :username, {
    uniqueness: true,
    format: {
      with: USERNAME_REGEXP,
      message: USERNAME_MESSAGE
    }
  }

  validates :email, {
    uniqueness: true,
    format: {
      with: URI::MailTo::EMAIL_REGEXP
    }
  }

  validates :password, {
    format: {
      with: PASSWORD_REGEXP,
      message: PASSWORD_MESSAGE
    }
  }

  before_save :format_name
  after_create :attach_default_avatar

  private def format_name
    lowercase_name = self.name.downcase()
    capitalized_words = lowercase_name.split(" ").map() do |word|
      word.capitalize()
    end
    self.name = capitalized_words.join(" ")
  end

  private def attach_default_avatar
    avatar_path = "#{::Rails.root}/storage/defaults/default_avatar.png"
    self.avatar.attach(io: File.open(avatar_path), filename: "default_avatar.png", content_type: "image/png")
  end

  def get_post_count
    self.posts.length
  end

  def get_follower_count
    self.followers.length
  end

  def get_followed_count
    self.followed.length
  end

end