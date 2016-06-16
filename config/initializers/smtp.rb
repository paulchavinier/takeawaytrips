ActionMailer::Base.smtp_settings = {
  address: 'smtp.postmarkapp.com',
  port: '25',
  domain: 'heroku.com',
  user_name: ENV['POSTMARK_API_TOKEN'], #variable d environnement
  password: ENV['POSTMARK_API_TOKEN'], #variable d environnement
  authentication: :cram_md5,
  enable_starttls_auto: true
}

