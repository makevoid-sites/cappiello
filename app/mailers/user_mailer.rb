class UserMailer < ActionMailer::Base
  default :from => "noreply@accademia-cappiello.it"
  
  def welcome(user)
    @user = user
    mail to: user.email, subject: user.en? ? "Accademia Cappiello - Welcome" : "Accademia Cappiello - Benvenuto"
  end
end