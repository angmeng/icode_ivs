# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => 'uni_session',
  :secret      => '5fcd83dc29b3293251daee751389f0f386be75767bv6ed372e54030c0e347cdc7369a5fb5e092c1fbdacd1606de7273edcb861afbb61894fd162a8238b4c6bad'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
