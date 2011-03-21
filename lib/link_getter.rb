path = File.expand_path "../", __FILE__

file = File.read "#{path}/old_site_links.txt"

pages = []

file.split("\n").each do |line|
  match = line.match(/(http:\/\/(.+)\.(asp|html))(.+) f/)
  if match
    pages << match[1].gsub("http://www.accademia-cappiello.it", '')
  end
end

require 'pp'
pp pages.uniq

# old links
# 
# ["http://www.accademia-cappiello.it/indexMaster.asp",
#  "http://www.accademia-cappiello.it/eventiDett.asp",
#  "http://www.accademia-cappiello.it/stages.asp",
#  "http://www.accademia-cappiello.it/corsiIni.asp",
#  "http://www.accademia-cappiello.it/newsDett.asp",
#  "http://www.accademia-cappiello.it/contatti.asp",
#  "http://www.accademia-cappiello.it/dateOrari.asp",
#  "http://www.accademia-cappiello.it/news.asp",
#  "http://www.accademia-cappiello.it/index.asp",
#  "http://www.accademia-cappiello.it/lavoro.asp",
#  "http://www.accademia-cappiello.it/corsiSpecial.asp",
#  "http://www.accademia-cappiello.it/form.asp",
#  "http://www.accademia-cappiello.it/lavoroOffroDett.asp",
#  "http://www.accademia-cappiello.it/eventi.asp",
#  "http://www.accademia-cappiello.it/borse.asp",
#  "http://www.accademia-cappiello.it/lavoroCercoDett.asp",
#  "http://www.accademia-cappiello.it/html/eventi.html",
#  "http://www.accademia-cappiello.it/html/stagesgratis.html",
#  "http://www.accademia-cappiello.it/html/news_html.asp",
#  "http://www.accademia-cappiello.it/html/cors_nf.html",
#  "http://www.accademia-cappiello.it/html/contatto.html",
#  "http://www.accademia-cappiello.it/html/illustrazione.html",
#  "http://www.accademia-cappiello.it/html/borse.html",
#  "http://www.accademia-cappiello.it/html/chis_nf.html",
#  "http://www.accademia-cappiello.it/html/corsibrevi_nf.html",
#  "http://www.accademia-cappiello.it/index.html",
#  "http://www.accademia-cappiello.it/html/lavoro.html"]