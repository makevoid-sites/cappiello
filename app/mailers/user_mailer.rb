class UserMailer < ActionMailer::Base
  
  ADMIN = Rails.env == "development" ? "makevoid@gmail.com" : "accademia-cappiello@dada.it"
  
  default :from => "noreply@accademia-cappiello.it"
  
  def welcome(user)
    @user = user
    mail to: user.email, subject: user.en? ? "Accademia Cappiello - Welcome" : "Accademia Cappiello - Benvenuto"
  end
  
  def admin_pdf(user)
    @user = user
    mail to: ADMIN, subject: "PDF scaricato - #{@user.name}"
  end
  
  def admin_borsa(user)
    @user = user
    mail to: ADMIN, subject: "Nuova richiesta Borsa di studio - #{@user.name}"
  end
  
  def admin_form(user)
    @user = user
    mail to: ADMIN, subject: "Form Inviato - #{@user.name}"
  end
end