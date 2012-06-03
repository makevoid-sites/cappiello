module CodeHistory

  CONFIGS = {
    max_versions: 100
  }

  class Document
    def initialize(file)
      @file = File.read(file)
    end

    def save
      @file
    end
  end

end


watch('.+\.rb')  do |file|
  puts "reloaded: #{file}"
  Document.new(file).save
end