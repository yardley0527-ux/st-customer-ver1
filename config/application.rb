require_relative "boot"
require "rails/all"
Bundler.require(*Rails.groups)

module SmartadminRailsSeed
  class Application < Rails::Application
    config.load_defaults 6.0

    config.autoload_lib(ignore: %w(assets tasks))
    config.app = '苼莛國際 CRM 後台'
    config.version = "1.0"
    config.user = 'default'
    config.avatar = "avatar-placeholder.png"
    config.logo = "smartadmin-logo.png"
    config.app_flavor = "苼莛國際 CRM 後台"
    config.avatar = "avatar-admin.png"
    config.app_layout_shortcut = true
    config.layout_settings = true
    config.chat_interface = true
    config.bs4v = true
    config.copyright_inverse = true
    config.email = "admin@example.com"
    config.copyright = "© 2025 苼莛國際. All Rights Reserved."
    config.app_name ="苼莛國際 CRM 後台"
  end
end
