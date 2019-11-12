class Follow < ApplicationRecord
  include ValidationErrorMessages

  belongs_to :followed, class_name: :User
  belongs_to :follower, class_name: :User

  # validate :cannot_follow_self

  validates :follower, {
    uniqueness: {
      scope: :followed,
      message: ALREADY_FOLLOWED
    }
  }

  # def cannot_follow_self
  #   if follower == followed
  #     errors.add(:follower, CANNOT_FOLLOW_SELF)
  #   end
  # end
  
end
