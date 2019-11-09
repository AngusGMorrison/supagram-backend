class ApplicationController < ActionController::API

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { errors: "Parameter missing" }, status: 400
  end

  def issue_token(data)
    JWT.encode(data, get_secret())
  end

  # def decode_token
  #   token = request.headers["token"]
  # end

  def get_secret
    ENV["SUPAGRAM_JWT_KEY"]
  end

end
