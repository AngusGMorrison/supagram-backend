class UserSerializer

  def initialize(user)
    @user = user
  end

  def serialize_with_auth_token(token)
    serialize_user().merge({ token: token })
  end

  def serialize_profile_owner
    { profile_owner: serialize_user()[:user] }
  end

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

end