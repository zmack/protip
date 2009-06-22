# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_protips_session',
  :secret      => '673845afbf7fb4ba72c560f7240194761a97192a5e1a728dade47828b47fbc3695ed0ba2bb5e405eb42bf707dd9d656f3c00a22deb2ffa2fe989c308e5c86aa7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
