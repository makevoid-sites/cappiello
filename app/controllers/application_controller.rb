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
  
  
  
  DataMapper::Validations::I18n.localize! 'it'
  DataMapper::Validations::I18n.translate_field_name_with :rails
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
  
  # redirect without www.
  
  before_filter :redirect_without_www
  
  def redirect_without_www
    split = request.host.split(".")
    if split[0] == "www"
      port = ":3000" if Rails.env == "development"
      redirect_to "http://#{split[1..-1].join(".")}#{port}#{request.path}"
    end
  end
  
  # Mixpanel

  before_filter :initialize_mixpanel

  def initialize_mixpanel
    @mixpanel = Mixpanel.new(MIXPANEL_TOKEN, request.env, true)
  end
  
  def track(event, properties={})
    user = !current_user.nil? ? @current_user.name : "Unregistered"
    anon_cookie = !@current_user.nil? ? @current_user.anonym_id : session[:anonym_id]
    @mixpanel.track_event event, properties.merge( user: user , cookie: anon_cookie) if Rails.env == "production"
  end
    
  def track_page(event_name)
    properties = { page: @page.title_it }
    track "page", properties
  end
  
  # Auth(orization)
  
  def admin_only
    not_found unless admin?
  end
  
  def logged_only
    not_found unless logged_in?
  end
  
  helper_method :superadmin?, :admin?
  
  def superadmin?
    current_user.id == 1 unless current_user.nil?
  end
  
  def admin?
    current_user.admin? unless current_user.nil?
  end
  
  
  # Auth(entication)
  
  helper_method :current_user, :logged_in?
  
  def logged_in?
    current_user
  end
  
  def current_user
    @current_user = User.get(session[:user_id]) if @current_user.nil?
    @current_user
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
  
  rescue_from DataMapper::ObjectNotFoundError, :with => :not_found
  
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
  
  def tf(first, last=first)
    english? ? last : first
  end
  
  helper_method :current_lang
  
  def current_lang
    english? ? "en" : "it"
  end
  
  before_filter :init_locale
  
  def init_locale
    DataMapper::Validations::I18n.localize! current_lang.to_s
    if english?
      DataMapper::Validations::I18n.translate_field_name_with(nil) { |x| x.to_s.humanize }
    else
      DataMapper::Validations::I18n.translate_field_name_with :rails
    end
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
