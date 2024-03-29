require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Kolkominate
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/app/form_builders)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

	  # Set special layout for some devise actions, such as login screen
    config.to_prepare do
      Devise::SessionsController.layout proc{ |controller| ['new'].include?(action_name) ? 'devise' : 'application' }
      #Devise::RegistrationsController.layout proc{ |controller| ['new'].include?(action_name) ? 'devise' : 'application' }
      Devise::RegistrationsController.layout 'devise'
      Devise::ConfirmationsController.layout 'devise'
      Devise::PasswordsController.layout 'devise'
      Devise::UnlocksController.layout 'devise'
    end

	  # Change style of the form fields with errors
	  ActionView::Base.field_error_proc = Proc.new { |html_tag, instance| html_tag }

    # mailer
    config.action_mailer.smtp_settings = {:enable_starttls_auto => false }
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      :address  => "smtp.coworking-piestany.sk",
      :port  => 25,
      :user_name  => "info@vinderhimlen.dk",
      :password  => "ICWP6212011",
      :authentication  => :login,
      #:domain => "vinderhimlen.dk",
      #:enable_starttls_auto => false,
      :openssl_verify_mode  => 'none'
    }
  end
end
