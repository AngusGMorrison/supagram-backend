require "rails_helper"

RSpec.describe UsersController, type: :controller do

  email = TestConstants::EMAIL
  password = TestConstants::PASSWORD
  incorrect_email = TestConstants::INCORRECT_EMAIL
  incorrect_password = TestConstants::INCORRECT_PASSWORD

  let(:request_sign_in) { post(:sign_in, params: { email: email, password: password }, format: :json) }
  let(:request_bad_sign_in) { post(:sign_in, format: :json) }

  before(:all) do
    user_factory = UserFactory.new()
    user_factory.create(email: email)
  end

  it "responds to /sign-in requests with json" do
    request_sign_in
    expect(response.content_type).to include("application/json")
  end

  it "responds to unsuccessful /sign-in requests with code 401" do
    request_bad_sign_in
    expect(response.status).to eq(401)
  end

  it "responds to unsuccessful /sign-in requests with an error message" do
    request_bad_sign_in
    expect(response.parsed_body()["error"]).to be_truthy()
  end

  it "rejects sign-in with an incorrect email" do
    post(:sign_in, params: { email: incorrect_email, password: password }, format: :json)
    expect(response.status).to eq(401)
  end

  it "rejects sign-in with an incorrect password" do
    post(:sign_in, params: { email: email, password: incorrect_password }, format: :json)
    expect(response.status).to eq(401)
  end

  it "responds to successful sign-in requests with code 200" do
    request_sign_in
    expect(response.status).to eq(200)
  end

  it "responds to successful /sign-in requests with a token" do
    request_sign_in
    expect(response.parsed_body()["token"]).to be_truthy()
  end

  it "generates a token from the User's id on successful sign-in" do
    token = JWT.encode(User.first.id, TestConstants::SECRET_KEY)
    request_sign_in
    response_token = response.parsed_body()["token"]
    expect(response_token).to eq(token)
  end

  it "responds to successful /sign-in requests with the User's username" do
    username = User.first.username
    request_sign_in
    expect(response.parsed_body()["user"]["username"]).to eq(username)
  end

  it "responds to successful /sign-in requests with the User's post_count" do
    post_count = User.first.get_post_count()
    request_sign_in
    expect(response.parsed_body()["user"]["post_count"]).to eq(post_count)
  end

  it "responds to successful /sign-in requests with the User's follower_count" do
    follower_count = User.first.get_follower_count()
    request_sign_in
    expect(response.parsed_body()["user"]["follower_count"]).to eq(follower_count)
  end

  it "responds to successful /sign-in requests with the User's followed_count" do
    followed_count = User.first.get_followed_count()
    request_sign_in
    expect(response.parsed_body()["user"]["followed_count"]).to eq(followed_count)
  end

end