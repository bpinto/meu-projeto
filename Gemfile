source 'http://rubygems.org'
gem 'coffee-script'
gem "devise", ">= 1.3.4"
gem 'gravtastic'
gem 'json'
gem 'jquery-rails'
gem 'mysql2'
gem 'rails', '3.1.0.rc1'
gem 'sass'
gem 'uglifier'

group :development, :test do
  gem "rspec-rails", ">= 2.6.1"
  gem 'ruby-debug'
  gem 'mongrel'
  gem 'awesome_print'
end

group :test do
  gem "capybara", ">= 1.0.0.beta1", :group => :test
  gem "cucumber-rails", ">= 0.5.1", :group => :test
  gem "database_cleaner", ">= 0.6.7", :group => :test
  gem "factory_girl_rails", ">= 1.1.beta1", :group => :test
  gem "launchy", ">= 0.4.0", :group => :test
  #gem 'spork'
  gem 'guard'
  #gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  #gem 'guard-spork'

  if `uname -a`.include? "Darwin" #Mac OSX
    gem 'rb-fsevent'
    gem 'growl'
  else
    gem 'rb-inotify'
    gem 'libnotify'
  end
end
