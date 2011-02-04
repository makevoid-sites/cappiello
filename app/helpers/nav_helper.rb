module NavHelper
  
  def nav(elements)
    elements.map do |element|
      haml_tag :li do
        haml_concat link_to(element.to_s.humanize, send("#{element}_path"))
      end
    end
  end
  
end