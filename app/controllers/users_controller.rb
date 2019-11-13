class UsersController < ApplicationController

  def sign_in
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      respond_with_token_and_user()
    else
      render json: { errors: "Invalid username or password" }, status: 401
    end
  end

  def sign_up
    @user = User.create(user_params())
    if @user.valid?()
      respond_with_token_and_user()
    else
      render json: { errors: @user.errors }, status: 400
    end
  end

  private def user_params
      params.require(:user).permit(:name, :username, :email, :password)
  end

  private def respond_with_token_and_user()
    token = issue_token({ user_id: @user.id })
    user_serializer = UserSerializer.new(@user)
    render json: user_serializer.serialize_with_token(token)
  end

  def show
    user = get_current_user()
    profile_user = User.find_by(username: params[:username])
    if profile_user
      profile_posts = profile_user.get_profile_posts(get_feed_start_datetime())
      post_serializer = PostSerializer.new(feed: profile_posts, user: user)
      render json: post_serializer.serialize_profile(profile_user), status: 200
    else
      render json: { errors: "Profile not found" }, status: 404
    end
  end

  # def change_avatar
  #   user = get_current_user()
  #   change_avatar()
  #   render json: user_serializer.s
  # end

  # private def change_avatar
  #   begin
  #     user.avatar = params[:avatar]
  #   rescue
  #     raise SupgramErrors::AvatarUploadError
  #   end
  # end

end
