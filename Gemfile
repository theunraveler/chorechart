source 'http://rubygems.org'

gem 'rails', '3.1.2'

gem 'thin'
gem 'jquery-rails'
gem 'devise'
gem 'schedule_atts', :git => 'git://github.com/theunraveler/Schedule-Attributes.git'
gem 'cancan'
gem 'foreigner'
gem 'activerecord-import'
gem 'twitter_bootstrap_form_for', :git => 'git://github.com/theunraveler/twitter_bootstrap_form_for.git'

gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-github'

group :development do
  gem 'bullet', :git => 'git://github.com/flyerhzm/bullet.git'
end

group :test do
  gem 'simplecov', :require => false
  gem 'capybara'
  gem 'cucumber'
  gem 'email_spec'    
  gem 'launchy'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'timecop'
  gem 'faker'
  gem 'database_cleaner'
  gem 'no_peeping_toms'
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
end

group :production do
  gem 'pg'
  gem 'rack-google-analytics', :require => 'rack/google-analytics'
end
  
group :assets do
  gem 'uglifier'
end
