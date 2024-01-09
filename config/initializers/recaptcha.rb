Recaptcha.configure do |config|
  config.site_key  = AppConfig.recaptcha&.site_key
  config.secret_key = AppConfig.recaptcha&.secret_key
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end