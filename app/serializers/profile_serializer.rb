class ProfileSerializer

  def initialize(profile:, profile_owner:, current_user:)
    @feed_serializer = FeedSerializer.new(feed: profile, current_user: current_user)
    @user_serializer = UserSerializer.new(user: profile_owner)
  end

  def serialize_as_json
    serialize.to_json()
  end

  private def serialize
    serialized_profile = @feed_serializer.serialize()
    serialized_profile_owner = @user_serializer.serialize_profile_owner()
    serialized_profile.merge(serialized_profile_owner)
  end

end