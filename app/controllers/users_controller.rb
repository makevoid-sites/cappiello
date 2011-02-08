# encoding: utf-8
class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.first(name_url: params[:name_url])
    return not_found if @user.nil?
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.tmp_password = params[:user][:password]
    if @user.save
      session[:user_id] = @user.id
      path = root_path
      path = @user.redirect_url unless @user.redirect_url.blank?
      UserMailer.deliver_welcome(@user)
      redirect_to path, notice: "La registrazione è andata a buon fine!"
    else
      flash[:error] = "Non è stato possibile completare la registrazione"
      render :new
    end
  end
  
  def edit
    #...
  end
  
  def update
    params[:admin] = false if params[:admin] == true
    
  end
  
end