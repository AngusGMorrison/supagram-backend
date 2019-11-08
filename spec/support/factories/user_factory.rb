class UserFactory

  NAME = Faker::Name.first_name,
  USERNAME = Faker::Internet.username(specifier: 4..30),
  EMAIL = Faker::Internet.email,
  PASSWORD = "password1^"

  def self.create(name: NAME, username: USERNAME, email: EMAIL, password: PASSWORD)
    User.create(
      name: name,
      username: username,
      email: email,
      password: password
    )
  end

end