class UserMailer < ActionMailer::Base

  #DEV = "nicco@filarete.it"
  DEV = "makevoid@gmail.com"
  #DEV = "cappiello@makevoid.com"

  # PROD = %w(makevoid@gmail.com accademiacappiello@dada.it)
  PROD = %w(info@accademiacappiello.it)

  ADMIN = Rails.env == "development" ? DEV : PROD
  #ADMIN = "makevoid@gmail.com"

  default from: MAIL_DEFAULT_FROM


  layout "mail"

  helper :users

  def welcome(user)
    @user = user
    mail to: user.email, subject: user.en? ? "Accademia Cappiello - Welcome" : "Accademia Cappiello - Benvenuto"
  end

  def reset_password(user)
    @user = user
    mail to: user.email, subject: user.en? ? "Accademia Cappiello - Reset Password" : "Accademia Cappiello - Ripristina la password`"
  end

  def admin_pdf(user, pdf)
    headers['Reply-To'] = user.email 
    @user = user
    @pdf = pdf.split("_").map{|w| w.capitalize}.join(" ")
    mail to: ADMIN, subject: "PDF scaricato - #{@user.name} - #{@pdf}"
  end

  def admin_borsa(user)
    headers['Reply-To'] = user.email
    @user = user
    mail to: ADMIN, subject: "Richiesta per Borsa di studio - #{@user.name}"
  end
  
  def admin_tutor(user)
    headers['Reply-To'] = user.email
    @user = user
    mail to: ADMIN, subject: "Form Tutor - Richiesta Incontro - #{@user.name}"
  end

  def admin_form(user)
    headers['Reply-To'] = user.email
    @user = user
    mail to: ADMIN, subject: "Form Inviato - #{@user.name}"
  end
end