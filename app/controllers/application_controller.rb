class ApplicationController < ActionController::API

def issue_token(data)
  JWT.encode(data, get_secret())
end

def decode_token
end

def get_secret
  ENV["SUPAGRAM_JWT_KEY"]
end

end
