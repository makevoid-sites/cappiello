class FormCreator
  
  def initialize(text)
    @text = text
  end
  
  # es: <Form[:borse_di_studio]>
  REGEX = /&lt;Form\[:(.+)\]&gt;/
  def insert(content="", &block)
    match = @text.match(REGEX)
    
    #raise REGEX.inspect
    unless match.nil?
      name = match[1]
      @text.gsub!(/#{REGEX}/, block.call(name))
    end
    
    #raise 
    # @text
    @text
  end
end