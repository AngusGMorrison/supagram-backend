require "../spec/support/factories/user_factory.rb"
require "../spec/support/factories/post_factory.rb"

user_factory = UserFactory.new()
post_factory = PostFactory.new()

10.times { user_factory.create() }

User.all.each() do |user|
  10.times { post_factory.create(user_id: user.id) }
end