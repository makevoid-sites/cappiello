require 'safariwatir'
require 'nokogiri'


@browser = browser = Watir::Safari.new

def parse
  Nokogiri::HTML @browser.html
end

SRC_URL = "http://www.trampi.istruzione.it/ricScu/ricarica.do"
URL = "http://www.trampi.istruzione.it/ricScu/cerca.do"

regions = ["ABRUZZO", "BASILICATA", "CALABRIA", "CAMPANIA", "EMILIA ROMAGNA", "FRIULI-VENEZIA ", "LAZIO", "LIGURIA", "LOMBARDIA", "MARCHE", "MOLISE", "PIEMONTE", "PUGLIA", "SARDEGNA", "SICILIA", "TOSCANA", "TRENTINO-ALTO A", "UMBRIA", "VENETO"]

def get_region(region)
  @browser.goto(SRC_URL)
  @browser.select_list(:name, "regione").select region
  sleep(1)
  @browser.select_list(:name, "tipologia").select "SCUOLA SECONDARIA DI II GRADO"
  sleep(1)
  @browser.select_list(:name, "order").select "DENOMINAZIONE"
  sleep(1)
  @browser.button(:value, "Cerca").click
  #f = browser.form(:action, "submit")
  #browser.wait
  sleep 1 until @browser.text.include? "ATTENZIONE: le scuole elencate"
end

def extract
  page = parse
  rows = page.search "table table tr"
  results = rows[2..-4].map do |row|
    tds = row.search("td")
    id = tds[1].search("a").text.strip
    name = tds[0].text.strip.gsub(/"/, '')
    { mail: "#{id}@istruzione.it", name: name }
  end
end

#regions.each do |region|
get_region("EMILIA ROMAGNA") # region
results = extract
#end

puts results.map{ |r| r[:mail] }.join("\n")