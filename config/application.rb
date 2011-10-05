require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Chorechart
  class Application < Rails::Application

    # Our human-readable app name
    config.app_name = 'Chorechart'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**}')]

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    config.active_record.observers = :assigner

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # CSS files you want as :defaults
    config.action_view.stylesheet_expansions = {
      :defaults => %w( jquery-ui/hot-sneaks/style.css bootstrap/bootstrap.css application.css )
    }

    # JavaScript files you want as :defaults (application.js is always included).
    config.action_view.javascript_expansions = {
      :defaults => %w( jquery jquery-ui jquery_ujs bootstrap/bootstrap-dropdown.js)
    }

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # So things can mail
    config.action_mailer.smtp_settings = { :address => 'localhost', :port => 25 }
    config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  end
end
