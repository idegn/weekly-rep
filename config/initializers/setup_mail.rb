if Rails.env == 'development'
  mail_settings = YAML.load(File.open('config/mail.yml'))
  ActionMailer::Base.smtp_settings = mail_settings[Rails.env] unless mail_settings[Rails.env].nil?
end
