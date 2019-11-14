class UserSerializer

  def initialize(user:)
    @user = user
  end

  def serialize_with_auth_token_as_json(token)
    serialize_with_auth_token(token).to_json()
  end

  private def serialize_with_auth_token(token)
    { 
      user: serialize(),
      token: token
    }
  end

  def serialize
    {
      username: @user.username,
      avatar: @user.get_avatar_url(),
      post_count: @user.get_post_count(),
      follower_count: @user.get_follower_count(),
      followed_count: @user.get_followed_count()
    }
  end

end