class DataMapper::Property
  def class_name
    self.class.name.split("::").last
  end
end

class Article
  include DataMapper::Resource

  property :id, Serial

  TRANSLATE = %w(title title_url text)

  require_relative "lang"
  Lang::LANGS.map do |t|
    property :"title_#{t}", String, length: 100, required: true, unique: true
    property :"title_url_#{t}", String, length: 100
    property :"text_#{t}", Text
  end

  property :created_at, DateTime
  property :article_type, String, index: true, default: "news" # ["news", "event"]

  # default_scope(:default).update order: [:created_at.desc]


  before :create do
    Lang::LANGS.map do |t|
      self.send("title_url_#{t}=", self.send("title_#{t}").title_urlize)
    end
  end

  def path(context)
    if article_type == "post"
      context.post_path self
    else
      context.article_path self
    end
  end

  def tipo
    article_type == "post" ? "post" : "news"
  end

  def self.news
    all(article_type: "news", :created_at.gt => Date.today-1)
  end

  def self.posts
    all(article_type: "post")
  end

  # def self.events
  #   all(article_type: "event")
  # end
end
