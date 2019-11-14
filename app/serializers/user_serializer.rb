class UserSerializer
  include Rails.application.routes.url_helpers

  def initialize(user)
    @user = user
  end

  def serialize_with_token(token)
    serialized_user = serialize_user().merge({ token: token })
    serialized_user.to_json()
  end


  # Sort issue of when to convert to JSON and how to name serialization methods
  # Does serialization imply a conversion to JSON or is it purely the structure of the hash thast matters?


  def serialize_user
    {
      user: {
        username: @user.username,
        avatar: @user.get_avatar_url(),
        post_count: @user.get_post_count(),
        follower_count: @user.get_follower_count(),
        followed_count: @user.get_followed_count()
      }
    }
  end

  def serialize_profile_owner
    { profile_owner: serialize_user()[:user] }
  end

end