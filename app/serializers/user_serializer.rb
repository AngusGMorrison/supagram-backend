class UserSerializer

  def initialize(user, token)
    @user = user
    @token = token
  end

  def serialize()
    {
      token: @token,
      user: {
        username: @user.username,
        post_count: @user.get_post_count(),
        follower_count: @user.get_follower_count(),
        followed_count: @user.get_followed_count()
      }
    }.to_json()
  end

end