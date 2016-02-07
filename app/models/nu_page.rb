class SimpleArticleFormat
  def self.load(file)
    content = File.read file
    new(content).parse
  end

  def initialize(content)
    @content = content
    @entities = []
  end

  def parse
    entities = @content.strip.split "---"
    entities.map do |entity|
      parse_entity entity
    end.compact
  end

  private

  # 3 regexes
  # ---------
  # 1) match "word: "
  # 2) match "word: word2"
  # 3) match "word> multiline words<"
  REGEX = /^(\w+):\s+()$|^(\w+):\s+(.+?)$|^(\w+)>([^<]+)</m

  def parse_entity(entity_string)
    entity = {}
    entity_string.scan(REGEX).each do |matches|
      name, value = matches.compact
      entity[name.to_sym] = value.strip
    end
    return if entity == {}
    entity
  end
end

Saf = SimpleArticleFormat
MH = Hashie::Mash

class NuPage

  PATH = Rails.root
  DIR = "#{PATH}/db/pages"

  def self.load_all
    pages = Dir.glob("#{DIR}/*_it.md").map do |name|
      name = File.basename name, ".md"
      name.gsub! /_it$/, ''
      name
    end
  end

  def self.load_all_saf
    pages = ALL.map do |name|
      page = Saf.load "#{DIR}/#{name}.saf"
      page = page.first
      page[:text_it] = File.read "#{DIR}/#{name}_it.md"
      # page[:text_en] = File.read "#{DIR}/#{name}_en.md"
      page
    end#.flatten

    pages.map{ |p| MH.new p }
  end

  def self.all
    ALL
  end

  def self.all_saf
    ALL_SAF
  end

  def self.find(title_url)
    all_saf.find{ |p| p.title_url_it == title_url }
  end

  ALL = load_all
  ALL_SAF = load_all_saf

end
