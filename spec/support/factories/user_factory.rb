require "rails_helper"

class UserFactory

  def initialize
    @password = TestConstants::PASSWORD
  end

  def create(name: create_first_name(), username: create_username(), email: create_email(), password: @password)
    User.create(
      name: name,
      username: username,
      email: email,
      password: password
    )
  end

  def create_without_name(username: create_username(), email: create_email(), password: @password)
    User.create(
      username: username,
      email: email,
      password: password
    )
  end

  def create_without_username(name: create_first_name(), email: create_email(), password: @password)
    User.create(
      name: name,
      email: email,
      password: password
    )
  end

  private def create_first_name
    Faker::Name.first_name
  end

  private def create_username
    Faker::Internet.username(specifier: 4..30)
  end

  private def create_email
    Faker::Internet.email
  end

end