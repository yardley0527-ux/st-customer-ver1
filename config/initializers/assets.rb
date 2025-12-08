# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"
Rails.application.config.assets.precompile += %w( smartadmin/miscellaneous/reactions/reactions.css )

Rails.application.config.assets.precompile += %w(
  smartadmin/miscellaneous/reactions/reactions.css
  smartadmin/miscellaneous/fullcalendar/fullcalendar.bundle
  smartadmin/miscellaneous/jqvmap/jqvmap.bundle
  smartadmin/**/*
  smartadmin/app.bundle.js
  smartadmin/vendors.bundle.js
  smartadmin/theme-demo.css
  smartadmin/holder.js
  smartadmin/logo.png
  smartadmin/fa-brands.css
  smartadmin/fa-regular.css
  smartadmin/fa-solid.css
  smartadmin/page-invoice.css
)
