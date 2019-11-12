class Follow < ApplicationRecord
  include ValidationErrorMessages

  belongs_to :followed, class_name: :User
  belongs_to :follower, class_name: :User

  validates :follower, {
    uniqueness: {
      scope: :followed,
      message: CANT_FOLLOW_SELF
    }
  }
  
end
