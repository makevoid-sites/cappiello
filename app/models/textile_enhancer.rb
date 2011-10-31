class TextileEnhancer
  
  REGEX = {
    form: /&lt;Form\[:(.+)\]&gt;/,      # <Form[:borse_di_studio]>
    gallery: /flickr_gallery\((\d+)\)/, # flickr_gallery(PHOTOSET_ID)
    vimeo: /vimeo\((\d+)\)/,
    image_left: /image_left\((.+)\)/,
    # flickr_link: /flickr_link\((\d+)\)/,
  }
  
  def initialize(text, regex=:form)
    @text = text
    @regex = REGEX[regex]
  end
  
  def insert(content="", &block)
    match = @text.match(@regex)
    
    #raise REGEX.inspect
    unless match.nil?
      name = match[1]
      @text.sub!(/<p>#{@regex}<\/p>/, block.call(name))
    end
    
    #raise 
    # @text
    
    @text
  end
end