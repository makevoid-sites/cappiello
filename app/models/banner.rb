class Banner
  LINKS = eval File.read("#{Rails.root}/config/banner_links.rb")

  def initialize(files)
    @images = []
    files.map do |file|
      image = {}
      image[:path] = file
      name = File.basename(file, ".png")
      image[:page_id] = LINKS[name]
      @images << image
    end

    page_ids = @images.map{ |image| image[:page_id] }
    pages = Page.all id: page_ids#, select: ["title_url_it", "title_url_en"]

    @images.each do |image|
      image[:page] = pages.get image[:page_id]
    end
  end

  def page(file)
    @images.find{ |img| img[:path] == file }[:page]
  end
end