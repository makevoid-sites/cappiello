class Banner
  LINKS = eval File.read("#{Rails.root}/config/banner_links.rb")

  def initialize
    @images = []

    files.map do |file|
      image = {}
      image[:path] = file
      name = File.basename(file, ".png")
      # puts "#{name} - #{LINKS[name]}" # debug
      image[:page_id] = LINKS[name]
      @images << image
    end

    page_ids = @images.map{ |image| image[:page_id] }
    pages = Page.all id: page_ids.compact#, select: ["title_url_it", "title_url_en"]

    @images.each do |image|
      image[:page] = pages.get image[:page_id]
    end
  end

  def files
    LINKS.map{ |name, id| "banner/main/#{name}.png" }
  end

  def page(path)
    @images.find{ |img| img[:path] == path }[:page]
  end
end