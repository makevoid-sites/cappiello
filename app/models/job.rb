class Job
  include DataMapper::Resource
  
  property :id, Serial
  property :title, String
  
  property :job_type, String, index: true # ["search", "offer"]
end
