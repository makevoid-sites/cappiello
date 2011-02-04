# encoding: utf-8

module TitleHelper
  
  def title(text=nil)
    unless text.nil?
      @title = text 
    else
      haml_tag :h2 do
        haml_concat @title
      end
    end
  end
  
  def title=(text)
    @title = text
  end
  
end

module SeoHelper
  
  def default_keywords
    english? ? "accademia, accademia cappiello, art school cappiello, leonetto cappiello, visual design, interior design, courses" : "accademia, accademia cappiello, scuola arte cappiello, leonetto cappiello, visual design, interior design, courses"
  end
  
  def default_description
    english? ? "The Academy of Art and Design Leonetto Cappiello is the perfect place to express their creativity and translate it into a real job opportunities. Visit the website to get informations about our courses in Visual and Interior Design." : "L'Accademia d'Arte e Design Leonetto Cappiello è il luogo ideale per esprimere la propria creatività e per tradurla in una reale opportunità di lavoro. Visita il sito per maggiori informazioni sui corsi di Visual e Interior Design."
  end
  
  def meta_keywords
    @page.nil? ? default_keywords : tr(@page).meta_keywords
  end
  
  def meta_description
    @page.nil? ? default_description : tr(@page).meta_description
  end
end

module UselessHelpers # at the end they are useful, you know :D
  def js_void
    "javascript:void(0)"
  end
end

module MarkupHelpers
  include TitleHelper
  include SeoHelper
  include UselessHelpers
end
  

