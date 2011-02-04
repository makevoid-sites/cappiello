# Be sure to restart your server when you modify this file.

# HOST_URL = "accademia-cappiello.it"
HOST_URL = "cappiello.makevoid.com"

Cappiello::Application.config.session_store :cookie_store, :key => '_cappiello_session', domain: ".#{Rails.env == "production" ? HOST_URL : "localhost"}"

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Cappiello::Application.config.session_store :active_record_store
