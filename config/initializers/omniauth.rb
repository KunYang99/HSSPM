Rails.application.config.middleware.use OmniAuth::Builder do
  # configure do |config|
  #   config.path_prefix = '/stocks/auth'
  # end

  provider :google_oauth2, ENV["StkMgr_CLIENT_ID"], ENV["StkMgr_CLIENT_SECRET"]
end
