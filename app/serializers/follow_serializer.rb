class FollowSerializer

  def initialize(follow, user)
    @followed = follow.followed
    @user = user
  end

  def serialize
    {
      user: {
        id: @followed.id,
        username: @followed.username,
        followed_by_current_user: @followed.followed_by?(@user)
      }
    }.to_json()
  end

end