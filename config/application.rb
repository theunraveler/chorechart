require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
if defined?(Bundler)
  # Precompile assets before deploying to production
  Bundler.require *Rails.groups(:assets => %w(development test))
end

module Chorechart
  class Application < Rails::Application

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this to expire all assets
    config.assets.version = '1.1.11'

    # Prevent whole Rails stack from loading on asset precompile (Devise, I'm
    # looking at you)
    config.assets.initialize_on_precompile = false

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += Dir[Rails.root.join('lib')]

    # Activate observers that should always be running.
    config.active_record.observers = :purger

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Remove div.field_with_errors
    config.action_view.field_error_proc = proc { |html, instance| html }

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Time zone
    config.time_zone = "Central Time (US & Canada)"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # So things can mail
    config.action_mailer.smtp_settings = { :address => 'localhost', :port => 25 }
    config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  end
end
