# Be sure to restart your server when you modify this file.

HOST_URL = "accademia-cappiello.it"


if Rails.env == "production"
  Cappiello::Application.config.session_store :cookie_store, :key => '_cappiello_session', domain: ".#{HOST_URL}", :expire_after => 3.months
end

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Cappiello::Application.config.session_store :active_record_store
# ActionController::Base.session = { :expire_after => 3.months }

# Cappiello::Application.config.session_store :cookie_store, :key => '_your_app_session', :domain => ".example.com"
