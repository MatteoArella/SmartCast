Koala.configure do |config|
  #config.app_access_token = MY_APP_ACCESS_TOKEN
  config.app_id = ENV['FACEBOOK_APP_ID']
  config.app_secret = ENV['FACEBOOK_SECRET_KEY']
end