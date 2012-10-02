class Country
  def self.all
    @@countries ||= eval File.read("#{Rails.root}/lib/countries.rb")
  end
end