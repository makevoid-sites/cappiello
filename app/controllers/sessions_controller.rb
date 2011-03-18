class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    user = User.first(email: params[:email])    
    user = User.first(nickname: params[:email]) if user.nil?
    if !user.nil? && user.auth?(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Hai effettuato l'accesso!"
    else
      flash[:error] = "Email o Password errate!"
      render :new
    end 
  end
  
  def destroy
    session[:user_id] = nil
    session[:anonym_id] = ""
    redirect_to root_path, notice: "Logout Effettuato"
  end
end