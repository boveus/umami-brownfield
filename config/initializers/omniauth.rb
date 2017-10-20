OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['google_id'], ENV['google_secret'], {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
  provider :twitter, ENV['twitter_id'], ENV['twitter_secret']
  provider :facebook, ENV['facebook_id'], ENV['facebook_secret']
end