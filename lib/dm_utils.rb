# encoding: utf-8

# TODO: move in voidtools
module DmUtils
  require 'ya2yaml'
  
    
  def dump_to_yaml(klass, filename="dump", path=nil)
    props = klass.properties.map{|p| p.name}
    objs = klass.all.map do |page|
      h = {}
      props.map do |prop|
        h[prop.to_s] = page[prop]
      end
      h
    end

    path = Rails.root if defined? Rails
    File.open("#{path}/db/#{filename}.yml", "w:UTF-8") do |f|     
      f.write objs.ya2yaml(:syck_compatible => true)
    end
  end

end
