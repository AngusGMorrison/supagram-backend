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
    user_serializer = UserSerializer.new(@user, token)
    render json: user_serializer.serialize()
  end

end
