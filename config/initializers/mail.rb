ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {  
  :user_name      => "m4kevoid@gmail.com",
  :password       => "finalman",
  :address        => "smtp.gmail.com",  
  :enable_starttls_auto => true,
  :authentication => :plain,
  :port           => 587
}