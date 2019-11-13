class Like < ApplicationRecord
  include ValidationErrorMessages

  belongs_to :post
  belongs_to :user

  validate :must_be_unique

  validates :user_id, {
    uniqueness: { 
      scope: :post_id,
      message: ALREADY_LIKED
    }
  }

end
