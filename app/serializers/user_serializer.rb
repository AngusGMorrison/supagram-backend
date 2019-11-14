class UserSerializer

  def initialize(user:, token: nil)
    @user = user
    @token = token
  end

  def serialize_with_auth_token_as_json
    serialize_with_auth_token.to_json()
  end

  private def serialize_with_auth_token
    serialize().merge({ token: @token }) 
  end

  def serialize_profile_owner
    { profile_owner: serialize()[:user] }
  end

  def serialize
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