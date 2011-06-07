class Work
  include DataMapper::Resource
  require 'voidtools/dm/paginable'
  include Voidtools::Paginable
  def self.per_page
    5
  end
  
  property :id, Serial
  property :name, String, length: 255
  property :created_at, DateTime
  property :text, Text 
  
end
