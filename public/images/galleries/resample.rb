#cp 1.jpg a.jpg; sips  a.jpg  -z 300 500

path = File.expand_path "../", __FILE__
Dir.glob("#{path}/home/*.*").map do |file|
  #p file
  # `sips #{file} -z 300 500`
  
  file = File.basename(file)
  p file
  `cd home; /opt/local/bin/convert #{file} -thumbnail 300x200^ -gravity center -extent 300x200  #{file.gsub(/jpg/, 'png')}`
  `cd home; rm -f #{file.gsub(/png/, 'jpg')}`
end