class Page
  include DataMapper::Resource
  storage_names[:default] = 'pages'

  property :id, Serial
  property :ptype, String, default: "standard"
  property :master, Boolean, default: false
  property :hidden, Boolean, default: false
  property :position, Integer
  property :int_name, String, length: 100

  TRANSLATE = %w(title title_url meta_keywords meta_description text)
  Lang::LANGS.map do |t|
    property :"title_#{t}", String, length: 100
    property :"title_url_#{t}", String, length: 100
    property :"meta_keywords_#{t}", String, length: 255
    property :"meta_description_#{t}", Text
    property :"text_#{t}", Text
  end

  is :tree

  # default_scope(:default).update hidden: false, order: :position

  def course?
    !root? || master?
  end

  def root?
    parent_id.nil?
  end

  def self.find_by_url(title_url_or_it)
    title = title_url_or_it
    title = title || "l_accademia"
    # page = Page.all(title_url_it: title)  | Page.all(title_url_en: title)
    # page = Page.all(title_url_it: title)#  | Page.all(title_url_en: title)
    # page.first
    Page.first(title_url_it: title)#  | Page.all(title_url_en: title)
  end

  # alias :load_page :find_by_url


  before :create do
    Lang::LANGS.map do |t|
      self.send("title_url_#{t}=", self.send("title_#{t}").title_urlize)
    end
  end
end
