class ProfileSerializer

  def initialize(profile:, profile_owner:, current_user:)
    @post_serializer = PostSerializer.new(posts: profile, user: current_user)
    @user_serializer = UserSerializer.new(user: profile_owner)
  end

  def serialize_as_json
    serialize.to_json()
  end

  private def serialize
    serialized_posts = @post_serializer.serialize_with_user
    serialized_profile_owner = @user_serializer.serialize()
    serialized_posts.merge({ profile_owner: serialized_profile_owner })
  end

end