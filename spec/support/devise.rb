RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.authentication_keys = [ :login ]
  config.reset_password_keys = [ :login ]
end
