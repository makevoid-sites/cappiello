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
      "<div id='photos' data-set_id='#{text}' ></div><a href='http://www.flickr.com/photos/accademiacappiello/sets/#{text}/' class='flickr_button'><img src='/images/icons/flickr_icon.png' /><span>Galleria immagini</span></a>"
    end


    TextileEnhancer.new(text, :vimeo).insert do |text|
      "<div id='video'><iframe src='http://player.vimeo.com/video/#{text}?title=0&amp;byline=0&amp;portrait=0&amp;color=C82D5E' frameborder='0'></iframe></div>"
    end

    text.scan(TextileEnhancer::REGEX[:image_left]).size.times do
      text = TextileEnhancer.new(text, :image_left).insert do |text|
        if text =~ /,/
          text = text.split(/,/)
          "<a href='#{text[1]}'><img src='#{text[0]}' class='image_left' /></a>"
        else
          "<img src='#{text}' class='image_left' />"
        end
      end
    end

    text
  end

  def request_url
    "http://"+request.host+request.fullpath
  end

  # og

  def og_image
    if @page && File.exist?("#{Rails.root}/public/images/og_images/#{@page.id}.png")
      "http://accademia-cappiello.it/images/og_images/#{@page.id}.png"
    else
      "http://accademia-cappiello.it/images/logo.png"
    end
  end

  # markup (redlcth)

  def markup(text)
    RedCloth.new( text.to_s ).to_html
  end

  def truncate(string, max=200)
    if string.size > max
      "#{string[0..max]}..."
    else
      string
    end
  end

  # patched form helper
  TRANSLATIONS = {
    "First name"  => "Nome",
    "Last name"   => "Cognome",
  }


  def patch_validation_error(error)
    TRANSLATIONS.each do |key, value|
      error.sub! key, value
    end
    error
  end

  def error_messages_for(entity)
    obj = if entity.is_a? (Symbol) || entity.is_a?(String)
      instance_variable_get("@#{entity.to_s}")
    else
      entity
    end
    return nil if obj.errors.map{ |e| e } == []
    haml_tag :ul, { class: "error_messages" } do
      obj.errors.map do |err|
        haml_tag(:li){ haml_concat patch_validation_error(err[0].to_s) }
      end
    end
  end


end
