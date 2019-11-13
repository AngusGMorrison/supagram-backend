class Like < ApplicationRecord
  include ValidationErrorMessages

  belongs_to :post
  belongs_to :user

  validates :user_id, {
    uniqueness: { 
      scope: :post_id,
      message: ALREADY_LIKED
    }
  }

end
