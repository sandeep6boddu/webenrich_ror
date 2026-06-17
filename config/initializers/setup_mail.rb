ActionMailer::Base.smtp_settings = {
  :user_name => 'sandeep@webenrich.com',
  :password => 'glvi deoj oyci wgtq',
  :domain => 'webenrich.com',
  :address => 'smtp-relay.gmail.com',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
ActionMailer::Base.default_url_options = { host: 'webenrich.com' }
