class Work
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, length: 255
  property :created_at, DateTime
  property :text, Text 
  
end
