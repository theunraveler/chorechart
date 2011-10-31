source 'http://rubygems.org'

gem 'rails', '3.1.1'

gem 'jquery-rails'
gem 'devise'
gem 'oa-core', :require => 'omniauth/core'
gem 'oa-oauth', :require => 'omniauth/oauth'
gem 'schedule_atts', :git => 'git://github.com/theunraveler/Schedule-Attributes.git'
gem 'escape_utils'
gem 'cancan'
gem 'foreigner'
gem 'prawn'
gem 'activerecord-import', '>= 0.2.0'
gem 'twitter_bootstrap_form_for', :git => 'git://github.com/theunraveler/twitter_bootstrap_form_for.git'

group :test do
  gem 'simplecov', :require => false
  gem 'capybara'
  gem 'cucumber'
  gem 'email_spec'    
  gem 'launchy'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'timecop'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'thin'
  gem 'mysql2'
  gem 'rspec-rails'  
  gem 'cucumber-rails'
end

group :production do
  gem 'rack-google-analytics', :require => 'rack/google-analytics'
end
