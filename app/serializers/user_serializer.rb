class UserSerializer
  include Rails.application.routes.url_helpers

  def initialize(user)
    @user = user
  end

  def serialize_with_token(token)
    serialized_user = serialize().merge({ token: token })
    serialized_user.to_json()
  end


  # Sort issue of when to convert to JSON and how to name serialization methods
  # Does serialization imply a conversion to JSON or is it purely the structure of the hash thast matters?


  def serialize()
    {
      user: {
        username: @user.username,
        avatar: get_avatar_url(),
        post_count: @user.get_post_count(),
        follower_count: @user.get_follower_count(),
        followed_count: @user.get_followed_count()
      }
    }
  end

  private def get_avatar_url()
    url_for(@user.avatar)
  end

end