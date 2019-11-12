class UserSerializer
  include Rails.application.routes.url_helpers

  def initialize(user, token)
    @user = user
    @token = token
  end

  def serialize()
    {
      token: @token,
      user: {
        username: @user.username,
        avatar: get_avatar_url(),
        post_count: @user.get_post_count(),
        follower_count: @user.get_follower_count(),
        followed_count: @user.get_followed_count()
      }
    }.to_json()
  end

  private def get_avatar_url()
    url_for(@user.avatar)
  end

  end

end