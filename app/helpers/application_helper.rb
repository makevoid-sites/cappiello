module ApplicationHelper
  include ViewHelpers
  include Voidtools::FormHelpers
  include UrlHelpers
  include MarkupHelpers

  def admin?
    current_user.admin? unless current_user.nil?
  end

  def master?
    # return false if @page.nil?
    # @page.master?
    false
  end
  
  def home_page?
    ["l_accademia", "1", "about_us"].include? params[:id]
  end
  
  def pages
    @pages ||= Page.all(master: false).roots
  end
  
  def parse_text(text)
    FormCreator.new(text).insert do |text| 
      if text =~ /pdf/
        pdf = text.gsub(/^pdf_/, '')
        text = "pdf"
      end
      
      if File.exist? "#{Rails.root}/app/views/forms/_#{text}.html.haml" 
        render partial: "forms/#{text}", locals: { pdf: pdf  }
      else
        "<p>Errore: Form con nome '#{text}' non trovato!</p>"
      end
    end
  end
  
  
  # markup (redlcth)
  
  def markup(text)
    RedCloth.new( text.to_s ).to_html 
  end
end
