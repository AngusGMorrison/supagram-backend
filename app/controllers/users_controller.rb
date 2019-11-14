class UsersController < ApplicationController
  include ControllerErrorMessages

  def sign_in
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      respond_with_user_and_auth_token()
    else
      render json: { errors: AUTHENTICATION_FAILED }, status: 401
    end
  end

  def sign_up
    @user = User.create(user_params())
    if @user.valid?()
      respond_with_user_and_auth_token()
    else
      render json: { errors: @user.errors }, status: 400
    end
  end

  private def user_params
      params.require(:user).permit(:name, :username, :email, :password)
  end

  private def respond_with_user_and_auth_token()
    token = issue_token({ user_id: @user.id })
    serializer = UserSerializer.new(user: @user, token: token)
    response = serializer.serialize_with_auth_token_as_json()
    render json: response, status: 200
  end

  def show
    @user = get_current_user()
    @profile_owner = User.find_by(username: params[:username])
    if @profile_owner
      respond_with_profile_feed()
    else
      render json: { errors: "Profile not found" }, status: 404
    end
  end

  private def respond_with_profile_feed()
    profile = @profile_owner.get_profile_feed(get_feed_start_datetime())
    serializer = ProfileSerializer.new(profile: profile, profile_owner: @profile_owner, current_user: @user)
    response = serializer.serialize_as_json()
    render json: response, status: 200
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
