MAIL_DEFAULT_FROM = "noreply@accademia-cappiello.it"
# MAIL_DEFAULT_FROM = "cappiello@makevoid.com"

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name      => MAIL_DEFAULT_FROM,
  :password       => File.read(File.expand_path("~/.password")).strip.gsub(/33/, ''),
  :address        => "smtp.gmail.com",
  :enable_starttls_auto => true,
  :authentication => :plain,
  :port           => 587
}