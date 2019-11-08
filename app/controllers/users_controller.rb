class UsersController < ApplicationController

  def sign_in
    user = User.find(params[:email])
    if user && user.authenticate(params[:password])
      render json: {
        token: issueToken(),
        user: {
          id: user.id,
          username: user.username,
          post_count: nil,
          follower_count: nil,
          following_count: nil,
          feed: nil
        }
      }
    else
      render json: { error: "Invalid username or password" }
    end
  end

  def sign_up
  end

end
