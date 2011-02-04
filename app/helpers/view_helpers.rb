module ViewHelpers
  
  include NavHelper
  
  # basic texts
  
  def site_title(content=nil)
    "Accademia d'Arte e Design Leonetto Cappiello #{content} - Firenze"
  end
  
  def footer_text
    raw "&copy;#{Time.now.year} Accademia Cappiello - Firenze"
  end
  
  # SEO (and RDF)
  
  def analytics_tracker
    "UA-20626831-1"
  end
  
  def meta_author
    "Francesco 'makevoid' Canessa"
  end
  
end