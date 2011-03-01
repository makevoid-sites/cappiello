class Photo
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  
  attr_accessor :file
end
