class ApplicationController < ActionController::API

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { errors: "Parameter missing" }, status: 400
  end

  def get_current_user
    user_id = decode_token()["user_id"]
    User.find_by(id: user_id)
  end

  def issue_token(data)
    JWT.encode(data, get_secret())
  end

  def decode_token
    token = request.headers["Authorization"]
    JWT.decode(token, get_secret()).first
  end

  def get_secret
    ENV["SUPAGRAM_JWT_KEY"]
  end

end
