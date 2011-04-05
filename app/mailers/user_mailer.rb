class UserMailer < ActionMailer::Base
  
  ADMIN = Rails.env == "development" ? "makevoid@gmail.com" : %w(accademia-cappiello@dada.it makevoid@gmail.com) 
  #ADMIN = "makevoid@gmail.com"
    
  default :from => "noreply@accademia-cappiello.it"
  
  helper :users  
  
  def welcome(user)
    @user = user
    mail to: user.email, subject: user.en? ? "Accademia Cappiello - Welcome" : "Accademia Cappiello - Benvenuto"
  end
  
  def admin_pdf(user, pdf)
    @user = user
    @pdf = pdf.split("_").map{|w| w.capitalize}.join(" ")
    mail to: ADMIN, subject: "PDF scaricato - #{@user.name} - #{pdf}"
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