source 'http://rubygems.org'

gem 'rails', '3.2.1'

gem 'jquery-rails'
gem 'devise'
gem 'ice_cube', '0.6.14'
gem 'schedule_atts', :git => 'git://github.com/theunraveler/Schedule-Attributes.git'
gem 'cancan'
gem 'foreigner'
gem 'activerecord-import'
gem 'twitter_bootstrap_form_for', :git => 'git://github.com/tzeskimo/twitter_bootstrap_form_for.git'

gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-github'

gem 'json_pure'
gem 'json'

group :test do
  gem 'simplecov', :require => false
  gem 'capybara'
  gem 'cucumber'
  gem 'email_spec'    
  gem 'launchy'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'timecop'
  gem 'ffaker'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'mysql2'
  gem 'rspec-rails'  
  gem 'cucumber-rails'
  gem 'rb-fsevent', :require => false
  gem 'growl', :require => false
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-rspec'
  gem 'rails_best_practices'
  gem 'thin'
  gem 'heroku'
end

group :production do
  gem 'unicorn'
  gem 'pg'
  gem 'rack-google-analytics', :require => 'rack/google-analytics'
end
  
group :assets do
  gem 'uglifier'
end
