Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_SECRET_KEY']#, ENV['ACCESS_TOKEN'], ENV['ACCESS_TOKEN_SECRET']
end