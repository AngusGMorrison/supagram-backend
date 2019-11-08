RSpec.configure do |config|

  config.before(:all) do
    DatabaseCleaner.clean_with :truncation, except: ["ar_internal_metadata"]
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end