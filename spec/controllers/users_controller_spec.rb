require "rails_helper"

RSpec.describe UsersController, type: :controller do

  name = TestConstants::NAME
  username = Faker::Internet.username(specifier: 4..30)
  email = TestConstants::EMAIL
  password = TestConstants::PASSWORD
  incorrect_email = TestConstants::INCORRECT_EMAIL
  incorrect_password = TestConstants::INCORRECT_PASSWORD

  describe "/sign-in" do
    let(:request_sign_in) { post(:sign_in, params: { email: email, password: password }, format: :json) }
    let(:request_bad_sign_in) { post(:sign_in, format: :json) }

    before(:all) do
      user_factory = UserFactory.new()
      user_factory.create(email: email)
    end

    it "responds to requests with json" do
      request_sign_in
      expect(response.content_type).to include("application/json")
    end

    it "responds to unsuccessful requests with code 401" do
      request_bad_sign_in
      expect(response.status).to eq(401)
    end

    it "responds to unsuccessful requests with an error message" do
      request_bad_sign_in
      expect(response.parsed_body()["errors"]).to be_truthy()
    end

    it "rejects sign-in with an incorrect email" do
      post(:sign_in, params: { email: incorrect_email, password: password }, format: :json)
      expect(response.status).to eq(401)
    end

    it "rejects sign-in with an incorrect password" do
      post(:sign_in, params: { email: email, password: incorrect_password }, format: :json)
      expect(response.status).to eq(401)
    end

    it "responds to successful requests with code 200" do
      request_sign_in
      expect(response.status).to eq(200)
    end

    it "responds to successful requests with a token" do
      request_sign_in
      expect(response.parsed_body()["token"]).to be_truthy()
    end

    it "generates a token from the User's id on successful sign-in" do
      token = JWT.encode(User.last.id, TestConstants::SECRET_KEY)
      request_sign_in
      response_token = response.parsed_body()["token"]
      expect(response_token).to eq(token)
    end

    it "responds to successful requests with the User's username" do
      username = User.last.username
      request_sign_in
      expect(response.parsed_body()["user"]["username"]).to eq(username)
    end

    it "responds to successful requests with the User's post_count" do
      post_count = User.last.get_post_count()
      request_sign_in
      expect(response.parsed_body()["user"]["post_count"]).to eq(post_count)
    end

    it "responds to successful requests with the User's follower_count" do
      follower_count = User.last.get_follower_count()
      request_sign_in
      expect(response.parsed_body()["user"]["follower_count"]).to eq(follower_count)
    end

    it "responds to successful requests with the User's followed_count" do
      followed_count = User.last.get_followed_count()
      request_sign_in
      expect(response.parsed_body()["user"]["followed_count"]).to eq(followed_count)
    end
  end

  describe "/sign-up" do
    let(:request_sign_up) do
      post(
        :sign_up,
        params: {
          user: {
            name: name,
            username: Faker::Internet.username(specifier: 4..30),
            email: Faker::Internet.email,
            password: password
          }
        },
        format: :json
      )
    end

    let(:request_bad_sign_up) do
      post(
        :sign_up,
        params: {},
        format: :json
      )
    end

    it "responds to requests with json" do
      request_sign_up
      expect(response.content_type).to include("application/json")
    end

    it "responds to unsuccessful requests with code 400" do
      request_bad_sign_up
      expect(response.status).to eq(400)
    end

    it "responds to unsuccessful requests with an error message" do
      request_bad_sign_up
      expect(response.parsed_body()["errors"]).to be_truthy()
    end

    it "responds to successful requests with code 200" do
      request_sign_up
      expect(response.status).to eq(200)
    end

    it "responds to successful requests with a token" do
      request_sign_up
      expect(response.parsed_body()["token"]).to be_truthy()
    end

    it "generates a token from the User's id on successful sign-up" do
      request_sign_up
      token = JWT.encode(User.last.id, TestConstants::SECRET_KEY)
      response_token = response.parsed_body()["token"]
      expect(response_token).to eq(token)
    end

    it "responds to successful requests with the User's username" do
      request_sign_up
      username = User.last.username
      expect(response.parsed_body()["user"]["username"]).to eq(username)
    end

    it "responds to successful requests with the User's post_count" do
      request_sign_up
      post_count = User.last.get_post_count()
      expect(response.parsed_body()["user"]["post_count"]).to eq(post_count)
    end

    it "responds to successful requests with the User's follower_count" do
      request_sign_up
      follower_count = User.last.get_follower_count()
      expect(response.parsed_body()["user"]["follower_count"]).to eq(follower_count)
    end

    it "responds to successful requests with the User's followed_count" do
      request_sign_up
      followed_count = User.last.get_followed_count()
      expect(response.parsed_body()["user"]["followed_count"]).to eq(followed_count)
    end
  end

end