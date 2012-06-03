# encoding: utf-8
class UsersController < ApplicationController

  before_filter :admin_only, only: [:index, :destroy, :newsletter]

  def index
    @users = User.paginate(:page => params[:page] )
  end

  def show
    @user = params[:name_url].inty? ? User.get(params[:name_url]) : User.first(name_url: params[:name_url])
    return not_found if @user.nil?
  end

  def new
    @user = User.new
  end

  def create
    correct_date_params
    params[:user][:anonym_id] = session[:anonym_id]
    @user = User.new(params[:user])
    @user.tmp_password = params[:user][:password]
    if params[:js_enabled] == "true" && @user.save
      session[:user_id] = @user.id
      path = session[:last_url] || root_path
      path = @user.redirect_url unless @user.redirect_url.blank?
      UserMailer.welcome(@user).deliver
      send_form_notification @user
      track :registration
      flash[:notice] = tf("La registrazione è andata a buon fine!", "You registered successfully!") if flash[:notice].blank?
      redirect_to path
    else
      flash[:error] = tf("Non è stato possibile completare la registrazione", "An error occurred during the registration")
      render :new
    end
  end

  def edit
    @user = User.get(params[:id])
    return(render text: tf("Error: You're not logged in or you're not editing your profile")) if @user != current_user && !admin?
  end

  def update
    correct_date_params
    params[:admin] = false
    @user = User.get(params[:id])
    return(render text: tf("Error: You're not logged in or you're not editing your profile")) if @user != current_user && !admin?
    if @user.update(params[:user])
      send_form_notification @user
      flash[:notice] = tf("La registrazione è andata a buon fine!", "You registered successfully!") if flash[:notice].blank?
      redirect_to @user
    else
      flash[:error] = tf("Non è stato possibile aggiornare il profilo")
      if params[:form] == "form"
        @page = Page.first(title_url_en: "form")
        raise NotFound if @page.nil?
        render "pages/show"
      else
        render :edit
      end
    end
  end

  def newsletter
    # John Dow,john@somedomain.com,Philadelphia,32
    @users = User.subscribers.map{ |user| "#{user.name},#{user.email},#{user.city}" }
  end

  # reset password

  def reset_password_form
  end

  def reset_password_send
    user = User.first email: params[:email]
    if user
      user.reset_password!
      UserMailer.reset_password(user).deliver
      render :reset_password_success
    else
      error = tf "Non e' stato trovato un'utente registrato con questa email.", "Sorry, no registered user found with this email"
      render :reset_password_form, error: error
    end
  end

  def reset_password_success
  end

  def reset_password_edit
    @user = User.first reset_password_token: params[:token]
  end

  def change_password
    @user = User.first reset_password_token: params[:token]
    if @user.update(params[:user])
      session[:user_id] = @user.id
      redirect_to root_path, notice: tf("La password tua e' stata cambiata!", "Your password has been changed")
    else
      render :reset_password_edit
    end
  end

  protected

  def send_form_notification(user, pdf=nil)
    form = params[:user][:tmp_form]
    unless form.blank?
      if form == "pdf"
        pdf = params[:user][:tmp_form_pdf]
        raise "PDF form has blank value" if pdf.blank?
        UserMailer.send("admin_#{form}", user, pdf).deliver
      else
        UserMailer.send("admin_#{form}", user).deliver
      end
    end
  end

  def correct_date_params
    obj = :user
    User.properties.each do |prop|
      attr = prop.name.to_s
      if prop.class_name.to_s == "Date" && !params[obj]["#{attr}(1i)"].blank?
        year  = params[obj]["#{attr}(1i)"].to_i
        month = params[obj]["#{attr}(2i)"].to_i
        day   = params[obj]["#{attr}(3i)"].to_i
        params[obj].delete "#{attr}(1i)"
        params[obj].delete "#{attr}(2i)"
        params[obj].delete "#{attr}(3i)"
        params[obj][attr] = Date.new(year, month, day)
      end
    end
  end

end