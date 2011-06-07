require 'mechanize'

agent = Mechanize.new
agent.user_agent = "Mac Safari"


SRC_URL = "http://www.trampi.istruzione.it/ricScu/ricarica.do"
URL = "http://www.trampi.istruzione.it/ricScu/cerca.do"

regions = []

region = "EMILIA+ROMAGNA"

params = "regione=EMILIA+ROMAGNA&provincia=&comune=&tipologia=SCUOLA+SECONDARIA+DI+II+GRADO&tipologia2=&denominazione=&codicemecc=&indirizzostudio=&order=DES_NOM"

page = agent.post URL, { regione: "EMILIA+ROMAGNA" }
puts page.body

# page = agent.get SRC_URL
# form = page.forms.first
# p form
# form.regione = "EMILIA ROMAGNA"
# form.tipologia = "SCUOLA SECONDARIA DI II GRADO"
# 
# page2 = form.submit
# puts page2.body
