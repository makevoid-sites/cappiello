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
  
  # require "#{Rails.root}/lib/tracking"
  # include Tracking
  
  # track non registered users with cookie
  after_filter :set_anonym_cookie
  
  require 'active_support/secure_random'
  
  def set_anonym_cookie
    #session[:anonym_id] = ""
    if session[:anonym_id].blank?
      if @user.nil?
        random_hash = ActiveSupport::SecureRandom.hex(16)
        session[:anonym_id] = random_hash
      else
        session[:anonym_id] = @user.anonym_id
      end
    end
    
  end
  
  
  # Mixpanel

  before_filter :initialize_mixpanel

  def initialize_mixpanel
    @mixpanel = Mixpanel.new(MIXPANEL_TOKEN, request.env, true)
  end
  
  def track(event, properties={})
    user = !@user.nil? ? @user.id : "Unregistered"
    anon_cookie = !@user.nil? ? @user.anonym_id : session[:anonym_id]
    @mixpanel.track_event event, properties.merge( user: user , cookie: anon_cookie) if Rails.env == "production"
  end
    
  def track_page(event_name)
    properties = { page: @page.title_it }
    track "page", properties
  end
  
  # Auth
  
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
    render file: "#{Rails.root}/public/404_cont_#{I18n.locale}.html", status: 404
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
