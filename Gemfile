source 'http://rubygems.org'
gem 'coffee-script'
gem "devise", ">= 1.3.4"
gem 'gravtastic'
gem 'json'
gem 'jquery-rails'
gem 'mysql2'
gem 'rails', '3.1.0.rc1'
gem 'sass'
#gem 'therubyracer'
gem 'therubyracer-heroku', '0.8.1.pre3'
gem 'uglifier'
gem 'heroku'

group :development, :test do
  gem 'awesome_print'
  gem "factory_girl_rails", ">= 1.1.beta1", :group => :test
  gem 'i18n-missing_translations'
  gem 'mongrel', '1.2.0.pre2'
  gem "rspec-rails", ">= 2.6.1"
  gem 'ruby-debug19'
end

group :test do
  gem "capybara", ">= 1.0.0.beta1", :group => :test
  gem "cucumber-rails", ">= 0.5.1", :group => :test
  gem "database_cleaner", ">= 0.6.7", :group => :test
  gem "launchy", ">= 0.4.0", :group => :test
  gem 'spork', "0.9.0.rc8"
  gem 'guard'
 #gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-spork'
  gem "shoulda-matchers"

  if `uname -a`.include? "Darwin" #Mac OSX
    gem 'rb-fsevent'
    gem 'growl'
  else
    gem 'rb-inotify'
    gem 'libnotify'
  end
end
