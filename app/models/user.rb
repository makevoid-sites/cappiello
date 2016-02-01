class User
  include DataMapper::Resource
  require 'voidtools/dm/paginable'
  include Voidtools::Paginable
  def self.per_page
    20
  end

  property :id, Serial
  property :first_name, String, required: true
  property :last_name, String, required: true
  property :nickname, String
  property :name_url, String
  property :email, String, required: true, unique: true
  property :password, String, required: true
  property :salt, String

  property :anonym_id, String, index: true
  # necessari per la registrazione alla scuola

  property :admin, Boolean, default: false
  #deny :write, :admin

  property :lang, String, index: true, default: "it"
  property :birthplace, String
  property :birthdate, Date
  property :address, String
  property :city, String
  property :cap, String
  property :tel, String

  property :newsletter,           Boolean, default: false

  property :interested_in, String, index: true
  property :int_annuali_visual,   Boolean, default: false
  property :int_annuali_interior, Boolean, default: false
  property :int_annuali_web, Boolean, default: false
  property :int_master_visual,   Boolean, default: false
  property :int_master_interior, Boolean, default: false
  property :int_evening,   Boolean, default: false
  property :int_evening_visual,   Boolean, default: false
  property :int_evening_interior,   Boolean, default: false
  property :int_brevi_visual,     Boolean, default: false
  property :int_brevi_interior,   Boolean, default: false
  property :int_workshop_visual,   Boolean, default: false
  property :int_workshop_interior, Boolean, default: false
  property :int_brevi_graphic,   Boolean, default: false
  property :int_stage_visual,     Boolean, default: false
  property :int_stage_interior,   Boolean, default: false
  property :int_stage_web,   Boolean, default: false
  property :int_stage_evening,   Boolean, default: false
  property :int_workshop_moda,   Boolean, default: false
  property :notes, Text

  property :qualification, String, length: 255
  property :grade, String
  property :job, String, length: 255

  property :created_at, DateTime
  property :updated_at, DateTime, index: true

  property :reset_password_token, String

  property :pdfs_downloaded_array, String, default: ""

  property :country, String, index: true

  5.times do |i|
    property "info#{i}", Text
  end


  # default_scope(:default).update order: [:updated_at.desc, :id.desc]


  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates_with_block :whole_name do
    if self.first_name != self.last_name
      [true]
    else
      [false, "Nome e cognome dovrebbero essere differenti / First and last names should be different"]
    end
  end

  validates_with_block :full_name do
    # unless self.saved?
      users_count = User.count(first_name: self.first_name, last_name: self.last_name)
      # raise self.new?.inspect
      num = self.new? ? 1 : 2
      if users_count < num
        [true]
      else
        [false, "Un utente con il tuo nome e cognome e' gia' registrato, probabilmente hai gia' un account. Prova a effettuare il <a href='/login'>login</a>. / There is another user with your first and last name, probably you already have an account. Try to <a href='/login'>login</a>."]
      end
    # end
  end

  attr_accessor :confirm, :redirect_url, :tmp_password, :tmp_form, :tmp_form_pdf


  def self.subscribers
    all(newsletter: true)
  end

  def name_pres
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
  def full_name
    "#{first_name} #{last_name}"
  end
  alias :name :full_name

  def en?
    self.lang == "en"
  end

  def pdfs_downloaded
    pdfs_downloaded_array.split(",")
  end

  def pdfs_downloaded_add(name)
    pdfs = pdfs_downloaded + [name]
    update(pdfs_downloaded_array: pdfs.uniq.join(","))
  end

  # auth

  def auth?(pass)
    self.password == encrypt_pass(pass)
  end

  def generate_salt
    self.salt = Digest::SHA1.hexdigest(rand(100000).to_s)[0..15]
  end

  def encrypt_pass(pass)
    Digest::SHA1.hexdigest "#{self.salt}_#{pass}"
  end

  def encrypt_password
    self.password = encrypt_pass(self.password)
  end

  before :create do
    generate_salt
    encrypt_password
  end

  attr_accessor :action_reset_pass
  before :update do
    if self.action_reset_pass
      encrypt_password
      self.reset_password_token = nil
      self.save
    end
  end

  # user pdf uploads

  APP_HOST = Rails.env == "development" ? "localhost:3000" : "accademia-cappiello.it"

  def cv?
    File.exists? "#{Rails.root}/public#{cv}"
  end

  def cv
    "/users_cv/#{id}.pdf"
  end

  def cv_url
    "http://#{APP_HOST}#{cv}"
  end

  def portfolio?
    File.exists? "#{Rails.root}/public#{portfolio}"
  end

  def portfolio
    "/users_portfolio/#{id}.pdf"
  end

  def portfolio_url
    "http://#{APP_HOST}#{portfolio}"
  end

  def user_image?
    File.exists? "#{Rails.root}/public#{user_image}"
  end

  def user_image
    File.exists?("#{Rails.root}/public/users_images/#{id}.jpg") ? "/users_images/#{id}.jpg" : "/users_images/#{id}.pdf"
  end

  def user_image_url
    "http://#{APP_HOST}#{user_image}"
  end

  # name url

  def generate_name_url(name)
    name.downcase.gsub(/'|\./, "").gsub(/\s/, "_")
  end

  before :create do
    self.name_url = generate_name_url(self.full_name)
  end

  # reset password

  def reset_password!
    self.reset_password_token = generate_reset_password_token
    self.save
  end

  private

  def generate_reset_password_token
    Digest::SHA1.hexdigest "#{Time.now.to_i }_antani"
  end

end
