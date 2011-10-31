module ApplicationHelper
  include ViewHelpers
  include Voidtools::FormHelpers
  include UrlHelpers
  include MarkupHelpers
  include UsersHelper

  require 'voidtools/sinatra/tracking'
  include Voidtools::Tracking

  def master?
    # return false if @page.nil?
    # @page.master?
    false
  end
  
  def pages
    @pages ||= Page.all(master: false).roots
  end
  
  def parse_text(text)
    TextileEnhancer.new(text, :form).insert do |text| 
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
    
    TextileEnhancer.new(text, :gallery).insert do |text|
      "<div id='photos' data-set_id='#{text}' ></div><a href='http://www.flickr.com/photos/accademiacappiello/sets/#{text}/' class='flickr_button'><img src='/images/icons/flickr_icon.png' /><span>Lavori degli studenti</span></a>"
    end

    
    TextileEnhancer.new(text, :vimeo).insert do |text|
      "<div id='video'><iframe src='http://player.vimeo.com/video/#{text}?title=0&amp;byline=0&amp;portrait=0&amp;color=C82D5E' frameborder='0'></iframe></div>"
    end
    
    text.scan(TextileEnhancer::REGEX[:image_left]).size.times do 
      text = TextileEnhancer.new(text, :image_left).insert do |text|
        "<img src='#{text}' class='image_left' />"
      end
    end
    
    text
  end
  
  
  # markup (redlcth)
  
  def markup(text)
    RedCloth.new( text.to_s ).to_html 
  end
  
end
