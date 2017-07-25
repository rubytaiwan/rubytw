require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rubytw
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Taipei'
    config.i18n.available_locales = %i[en zh-TW]
    config.i18n.default_locale = :'zh-TW'
    config.active_record.time_zone_aware_types = [:datetime]
    
    # Include Bower components in compiled assets
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
  end
end
