class UserMailer < ActionMailer::Base
  
  DEV = "makevoid@gmail.com" 
  #DEV = "cappiello@makevoid.com"
  
  ADMIN = Rails.env == "development" ? DEV : %w(accademiacappiello@dada.it makevoid@gmail.com) 
  #ADMIN = "makevoid@gmail.com"
    
  default :from => "noreply@accademia-cappiello.it"
  
  layout "mail"
  
  helper :users  
  
  def welcome(user)
    @user = user
    mail to: user.email, subject: user.en? ? "Accademia Cappiello - Welcome" : "Accademia Cappiello - Benvenuto"
  end
  
  def admin_pdf(user, pdf)
    @user = user
    @pdf = pdf.split("_").map{|w| w.capitalize}.join(" ")
    mail to: ADMIN, subject: "PDF scaricato - #{@user.name} - #{@pdf}"
  end
  
  def admin_borsa(user)
    @user = user
    mail to: ADMIN, subject: "Richiesta per Borsa di studio - #{@user.name}"
  end
  
  def admin_form(user)
    @user = user
    mail to: ADMIN, subject: "Form Inviato - #{@user.name}"
  end
end