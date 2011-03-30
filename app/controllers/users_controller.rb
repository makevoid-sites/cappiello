# encoding: utf-8
class UsersController < ApplicationController
  
  before_filter :admin_only, only: [:index, :destroy]  
  
  def index
    @users = User.all
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
    
    @user = User.new(params[:user])
    @user.tmp_password = params[:user][:password]
    if @user.save
      session[:user_id] = @user.id
      path = root_path
      path = @user.redirect_url unless @user.redirect_url.blank?
      UserMailer.deliver_welcome(@user)
      @user.update anonym_id: session[:anonym_id]
      track :registration
      redirect_to path, notice: "La registrazione è andata a buon fine!"
    else
      flash[:error] = "Non è stato possibile completare la registrazione"
      render :new
    end
  end
  
  def edit
    @user = User.get(params[:id])
  end
  
  def update
    correct_date_params
    params[:admin] = false if params[:admin] == true
    @user = User.get(params[:id])
    return(render text: tf("Error: You're not logged in or you're not editing your profile")) if @user != current_user && !admin?
    if @user.update(params[:user])
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
  
  protected
  
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