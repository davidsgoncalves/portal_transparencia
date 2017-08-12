require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PortalTransparencia
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.webpack = { use_manifest: false, asset_manifest: {}, common_manifest: {} }
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :pt
    config.time_zone = 'Brasilia'
  end
end
