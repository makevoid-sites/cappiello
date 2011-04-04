require 'dm-validations'
require 'yaml'

module DataMapper
  module Validations
    module I18n
      class << self
        cattr_accessor :locale
        cattr_accessor :field_name_translator

        def localize!(locale)
          self.locale = locale

          data = {}
          load_locale(locale).each do |key, value|
            data[key.to_sym] = value
          end
          DataMapper::Validations::ValidationErrors.default_error_messages = data
        end

        def translate_field_name_with(x = nil, &cb)
          self.field_name_translator =
            if (!x && cb)
              FieldNameTranslator::Callback.new(self, &cb)
            elsif (x.is_a? Hash)
              FieldNameTranslator::Hash.new(self, x)
            elsif (x == :rails)
              FieldNameTranslator::Rails.new(self)
            end
        end

        def load_locale(locale)
          load_yml File.join('/Users/makevoid/.rvm/gems/ruby-1.9.2-rc2/bundler/gems/dm-validations-i18n-182a1239e230/locale', "#{locale}.yml")
        end

        def load_yml(filename)
          YAML::load IO.read(filename)
        end
      end
    end

    module FieldNameTranslator
      class Callback
        attr_accessor :context, :callback

        def initialize(context, &cb)
          self.context  = context
          self.callback = cb
        end

        def translate(field)
          self.callback.call(field)
        end
      end

      class Hash < Callback
        def initialize(context, x)
          dict = x[context.locale]

          self.context = context
          self.callback = lambda do |field|
            dict[field.to_s] || field
          end
        end
      end

      class Rails < Callback
        def initialize(context)
          self.context = context
          self.callback = lambda do |field|
            ::I18n.t(field)
          end
        end
      end
    end
  end
end

class DataMapper::Validations::ValidationErrors
  class << self
    def default_error_message_with_localized_field_name(key, field, *values)
      translator = DataMapper::Validations::I18n.field_name_translator
      
      if translator
        field = translator.translate(field)
      end

      @@default_error_messages[key] % [field, *values].flatten
    end

    alias :default_error_message_without_localized_field_name :default_error_message
    alias :default_error_message :default_error_message_with_localized_field_name
  end
end

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
  
  # Auth(orization)
  
  def admin_only
    not_found unless admin?
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
  
  before_filter do
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
