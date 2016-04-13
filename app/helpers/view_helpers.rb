module ViewHelpers

  include NavHelper


  # basic texts

  def site_title(content=nil)
    # old: Accademia d'Arte e Design Leonetto Cappiello
    "#{content} Accademia d'Arte e Design Leonetto Cappiello Firenze"
  end

  def footer_text
    raw "&copy;#{Time.now.year} Accademia Cappiello - Firenze"
  end

  # SEO (and RDF)

  def analytics_tracker
    "UA-20626831-1"
  end

end