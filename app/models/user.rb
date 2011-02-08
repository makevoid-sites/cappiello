class User
  include DataMapper::Resource
  
  property :id, Serial
  property :first_name, String, required: true
  property :last_name, String, required: true
  property :nickname, String 
  property :name_url, String 
  property :email, String, required: true, unique: true
  property :password, String, required: true
  property :salt, String
  # necessari per la registrazione alla scuola

  property :admin, Boolean, default: false
  #deny :write, :admin

  property :lang, String, index: true, default: "it"
  property :birthplace, String
  property :birthdate, DateTime
  property :address, String
  property :city, String
  property :cap, String
  property :tel, String
  
  property :newsletter,           Boolean, default: false
  
  property :interested_in, String, index: true
  property :int_annuali_visual,   Boolean, default: false
  property :int_annuali_interior, Boolean, default: false
  property :int_brevi_visual,     Boolean, default: false
  property :int_brevi_interior,   Boolean, default: false
  property :int_stage_visual,     Boolean, default: false
  property :int_stage_interior,   Boolean, default: false
  property :notes, Text
  
  property :qualification, String
  property :grade, String 
  property :job, String

  5.times do |i|
    property "info#{i}", Text
  end

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  attr_accessor :confirm, :redirect_url, :tmp_password

  def full_name
    "#{first_name} #{last_name}"
  end

  def en?
    self.lang == "en"
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
  
  
  # name url
  
  def generate_name_url(name)
    name.downcase.gsub(/'/, "").gsub(/\s/, "_")
  end

  before :create do
    self.name_url = generate_name_url(self.full_name)
  end
  
end
