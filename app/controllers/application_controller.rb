# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery

  layout File.read("#{Rails.root}/config/layout.conf").strip


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

  helper_method :section

  def section
    request.path.split("/")[1]
  end


  helper_method :home_page?

  def home_page?
    # old: ["l_accademia", "1", "about_us"]
    ["news", "35"].include? params[:id]
  end


  before_filter :fix_txt_accept

  def fix_txt_accept
    request.format = :html if request.format.to_s =~ /text\/*/
  end


  before_filter :remember_last_url

  def remember_last_url
    if request.method == "GET"
      session[:last_url] = request.path unless ["/login", "/pages/info"].include? request.path
    end
  end


  DataMapper::Validations::I18n.localize! "it"
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

  before_filter :redirect_without_www if Rails.env == "production"

  def redirect_without_www
    split = request.host.split(".")
    redirect_to "http://#{split[1..-1].join(".")}#{port}#{request.path}" if split[0] == "www"
  end

  # Mixpanel

  # before_filter :initialize_mixpanel if Rails.env != "development"

  # def initialize_mixpanel
  #   @mixpanel = Mixpanel::Tracker.new(MIXPANEL_TOKEN, request.env, { async: true })
  # end

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
    raise NotFound unless admin?
  end

  def logged_only
    raise NotFound unless logged_in?
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

  # i18n - 2 languages

  helper_method :tr, :tf, :tm, :th

  module Internationalize
    def lang
      @lang
    end

    def lang=(lang)
      @lang = lang
      I18n.locale = lang
    end

    def method_missing(method)
      # puts "DEBUG pippo -- method: #{method}, lang: #{lang}, self: #{self}, class: #{self.class}"
      # if method.to_s == "to_ary"
      #   super
      # else
        # if (self ? self.class : Page)::TRANSLATE.include? method.to_s
          if self.class == Hashie::Mash
            self["#{method}_#{lang}"]
          else
            self.send "#{method}_#{lang}"
          end
        # end
      # end
    end
  end

  # TODO: change to tm implementation that is lighter and more understandable
  def tr(object)
    object.extend Internationalize
    object.lang = current_lang
    object
  end

  def tm(obj)
    obj.define_method :title do
      instance_method "title_#{current_lang}"
    end
    obj.define_method :title_url do
      instance_method "title_url_#{current_lang}"
    end
    obj.define_method :meta_description do
      instance_method "meta_description_#{current_lang}"
    end
    obj.define_method :meta_keywords do
      instance_method "meta_keywords_#{current_lang}"
    end
    obj.define_method :text do
      instance_method "text_#{current_lang}"
    end
    obj
  end

  def th(mh)
    mh[:"title"] = mh[:"title_#{current_lang}"]
    mh[:"title_url"] = mh[:"title_url_#{current_lang}"]
    mh[:"meta_description"] = mh[:"meta_description_#{current_lang}"]
    mh[:"meta_keywords"] = mh[:"meta_keywords_#{current_lang}"]
    mh[:"text"] = mh[:"text_#{current_lang}"]
    mh
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

  # before_filter :smooth_language_change
  #
  # def smooth_language_change
  #   if refered_domain_is_local && current_lang != referer_lang
  #     redirect_to #...
  #   end
  # end
  #
  # def referer_lang
  #   request.referer =~ /en\./ ? "en" : "it"
  # end
  #
  # def refered_domain_is_local
  #   request.referer.match request.domain if request.referer
  # end

  # subdomain and language

  helper_method :host_and_port, :subdomain, :english?, :italian?, :en?, :it?

  def subdomain
    "en"
  end

  def english?
    request.host.split(".")[0] == subdomain
  end

  alias :en? :english?

  def italian?
    !english?
  end

  alias :it? :italian?

  def app_host
    "#{request.host.gsub("#{subdomain}.", '')}"
  end

  def host_and_port
    Rails.env == "development" ? "#{app_host}:3000" : app_host
  end

end
