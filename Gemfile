source 'http://rubygems.org'
gem 'acts_as_commentable'
gem 'cancan'
gem 'coffee-script'
gem 'devise', '>= 1.4.2'
gem 'gravtastic'
gem 'heroku'
gem 'json'
gem 'jquery-rails'
gem 'mysql2'
gem 'paper_trail'
gem 'rails', '3.1.0'
gem 'sass'
#gem 'therubyracer'
gem 'therubyracer-heroku', '0.8.1.pre3'
gem 'uglifier'
gem 'validates_timeliness'

group :development, :test do
  gem 'awesome_print'
  gem 'factory_girl_rails', '>= 1.1.beta1'
  gem 'mongrel', '1.2.0.pre2'
  gem 'pry'
  gem 'rspec-rails', '>= 2.6.1'
end

group :test do
  gem 'capybara', '>= 1.0.0.beta1'
  gem 'cucumber-rails', '>= 0.5.1'
  gem 'database_cleaner', '>= 0.6.7'
  gem 'launchy', '>= 0.4.0'
  gem 'spork', '0.9.0.rc8'
  gem 'guard'
 #gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-spork'
  gem 'shoulda-matchers'

  if `uname -a`.include? 'Darwin' #Mac OSX
    gem 'rb-fsevent'
    gem 'growl'
  else
    gem 'rb-inotify'
    gem 'libnotify'
  end
end
