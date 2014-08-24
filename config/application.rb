require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require File.join(File.expand_path(File.dirname(__FILE__)), 'version.rb')
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.

Bundler.require(:default, Rails.env)

module OblakanRM
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Krasnoyarsk'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = :ru

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
        address:              'smtp.yandex.ru',
        port:                 25,
        domain:               'oblakan.ru',
        user_name:            ENV['ROBOT_EMAIL_USER'],
        password:             ENV['ROBOT_EMAIL_PASSWORD'],
        authentication:       'plain',
        enable_starttls_auto:  true
    }
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_deliveries = true
    host = if Rails.env.production?
            'report.oblakan.ru'
           else
            'report.oblakan.dev:3000'
           end
    config.action_mailer.default_url_options = { :host => host }
    config.cache_store = :redis_store, 'redis://localhost:6379/0/cache', { expires_in: 90.minutes }
  end
end
