# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rss_reader_session',
  :secret      => 'f0ee81b12c9ce56c85adc04406ac2a18a07774ab7cd4fa06f026c631cd001a3f3e50a133fec1d1d89bd51d5cb6dc6da29205ae0196f86d0cf9f537f671e3adcf'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
