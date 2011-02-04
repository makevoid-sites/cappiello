class ApplicationController < ActionController::Base
  protect_from_forgery
    
  # catch_404
  # around_filter do |controller, action_block| 
  #   controller do
  #     begin
  #       action_block.call 
  #     rescue NotFound
  #       raise "not found"
  #     end
  #   end
  #  end
  
  # TODO: registration, authentication
  
  helper_method :current_user, :logged_in?
  
  def logged_in?
    current_user
  end
  
  def current_user
    @current_user || User.get(session[:user_id])
  end
  
  
  around_filter :check_404
  
  def check_404
    begin
      yield
    rescue ActionView::Template::Error => e
      check_not_found(e)
    rescue NotFound => e      
      not_found
    end
  end
  
  def check_not_found(e)
    if e.message == "Pagina non trovata"
      not_found
    else
      raise e
    end
  end
  
  def not_found
    render file: "#{Rails.root}/public/404.html", status: 404
  end
  
  # english version
  
  helper_method :tr, :tf
  
  module Internationalize
    def lang
      @lang
    end
    
    def lang=(lang)
      @lang = lang
      I18n.locale = lang
    end
    
    def method_missing(method)
      if self.class::TRANSLATE.include? method.to_s
        self.send("#{method}_#{lang}")
      end
    end
  end
  
  def tr(object)
    object.extend Internationalize
    object.lang = current_lang
    object
  end
  
  def tf(first, last)
    english? ? last : first
  end
  
  helper_method :current_lang
  
  def current_lang
    english? ? "en" : "it"
  end
  
  # subdomain and language
  
  helper_method :host_and_port, :subdomain, :english?
  
  def subdomain
    "en"
  end 
  
  def english?
    request.host.split(".")[0] == subdomain
  end
  
  def app_host
    "#{request.host.gsub("#{subdomain}.", '')}"
  end
   
  def host_and_port
    Rails.env == "development" ? "#{app_host}:3000" : app_host
  end
  
end
