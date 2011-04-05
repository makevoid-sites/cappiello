ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {  
  #:user_name      => "cappiello@makevoid.com",
  :user_name      => "cappiello@makevoid.com",
  :password       => "secret",
  :address        => "smtp.gmail.com",  
  :enable_starttls_auto => true,
  :authentication => :plain,
  :port           => 587
}