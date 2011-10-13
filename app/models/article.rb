class DataMapper::Property
  def class_name
    self.class.name.split("::").last    
  end
end

class Article
  include DataMapper::Resource
  
  property :id, Serial
  
  TRANSLATE = %w(title title_url text)
  Lang::LANGS.map do |t|
    property :"title_#{t}", String, length: 100, required: true, unique: true
    property :"title_url_#{t}", String, length: 100
    property :"text_#{t}", Text    
  end
    
  property :created_at, DateTime
  property :article_type, String, index: true # ["news", "event"]
  
  default_scope(:default).update order: [:created_at.asc]
  
  
  before :create do
    Lang::LANGS.map do |t|
      self.send("title_url_#{t}=", self.send("title_#{t}").title_urlize)
    end
  end
  
  def tipo
    article_type == "news" ? "news" : "evento"
  end
  
  def self.news
    all(article_type: "news")
  end
  
  def self.events
    all(article_type: "event")
  end
end
