Recaptcha.configure do |config|
  config.site_key  = ENV["reCAPTCHA_key"]
  config.secret_key = ENV["reCAPTCHA_secret"]
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end
