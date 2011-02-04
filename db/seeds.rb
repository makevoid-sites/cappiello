# encoding: utf-8

path = File.expand_path "../../", __FILE__
unless defined?(Rails)

  require 'bundler'
  require 'bundler/setup'
  require 'dm-core'
  require 'dm-migrations'
  require 'dm-is-tree'

  models = "#{path}/app/models"
  models = Dir.glob "#{models}/*.rb"
  models.map do |model|
    require model
  end

  DataMapper.setup :default, "mysql://localhost/cappiello_development"
  DataMapper.auto_migrate!


  #File.open("#{path}/pages.yml", "w"){ |f| f.write pages.to_yaml }
end

# pages

pages = YAML::load File.read("#{path}/db/pages.yml")
pages.map do |page|
  pp = Page.create(page)
end

User.create(admin: true, first_name: "Francesco", last_name: "Canessa", nickname: "makevoid", email: "makevoid@gmail.com", password: "finalman")


require "#{path}/lib/dm_utils"
include DmUtils
dump_to_yaml(Page, "pages2", path)


# articles

articles = [
  {
    created_at: "23/11/2010",
    article_type: "news",
    title_it: "Corsi Brevi",
    text_it: "Inizio dei corsi brevi turno weekend dal 21 Gennaio 2011, con la novità, per quanto riguarda Interior Design, dell'introduzione di alcune ore di SketchUp. Informatevi subito: ci sono ancora alcuni posti disponibili sia per Interior che per Visual Design.

    Inizio dei corsi brevi turno pomeridiano dal 17 Gennaio 2011",

    title_en: "Short Courses",
    text_en: "Short courses will begin the 21st Jannuary 2011 for the weekend and will begin the 17th Jannuary 2011 for the afternoons both of  Interior Design and Visual Design. Novelty, for Interior: the introduction of a few hours of SketchUp. Find it now: there are still some places available for both",
  },
  {
    created_at: "29/11/2010",
    article_type: "news",
    title_it: "Stage gratuiti Visual Design",
    text_it: "24 GENNAIO 2011 Giornata di orientamento gratuito per coloro che sono interessati a conoscere tutti gli aspetti del corso annuale di Visual Design. Lo stage è completamente gratuito e non implica nessun impegno. Per partecipare è sufficiente iscriversi dal menu form.",

    title_en: "Free Visual Design stages",
    text_en: "24th Jannuary 2011 Orientation day free for those who are interested in all aspects of the annual course of Visual Design. The stage is completely free and does not imply any commitment. To participate, just join the Format menu.",
  },
  {
    created_at: "02/12/2010",
    article_type: "news",
    title_it: "Interior Design - stage gratuiti",
    text_it: "27 gennaio 2011 -  Giornata di orientamento gratuito per coloro che sono interessati a conoscere tutti gli aspetti del corso annuale di Visual Design. Lo stage è completamente gratuito e non implica nessun impegno. Per partecipare è sufficiente iscriversi dal menu form.",

    title_en: "Free stages - Interior Design",
    text_en: "27th Jannuary 2011 - Orientation day free for those who are interested in all aspects of the annual course of Interior Design. The stage is completely free and does not imply any commitment. To participate, just join the Format menu.",
  },
  {
    created_at: "19/12/2010",
    article_type: "news",
    title_it: "Borse di Studio - Corsi annuali Visual e Interior Design",
    text_it: "Scade il 16 Gennaio 2011 il termine per presentare domanda per le borse di studio dei corsi annuali di febbraio 2011: ci sono in palio 10 borse di studio del valore di 1700 euro ciascuna pari al 50% del costo di un semestre. Concorri subito: clicca nel menu BORSE DI STUDIO e compila l'apposito form.",

    title_en: "Scolarships",
    text_en: "Expires Jannuary 16th 2011 the deadline to apply for the scholarships of the annual course of February 2011: We are giving away 10 scholarships each worth 1700 euro 50% of the cost of a semester. Compete now: click on the menu SCHOLARSHIPS and fill out the form.",
  },
  {
    created_at: "21/02/2011",
    article_type: "news",
    title_it: "Corsi Annuali Visual e Interior Design",
    text_it: "Il 21 febbraio inizia il primo semestre dei nuovi corsi annuali di Visual Design e Interior Design. I corsi sono aperti a tutti: per avere il programma completo è sufficiente scaricarlo dal sito.",

    title_en: "Annual Courses Visual and Interior Design",
    text_en: "On 21 February the new semester begins on the first-year courses Visual Design and Interior Design. The courses are open to all: download the complete program from the site.",
  },
  {
    created_at: "09/11/2010",
    article_type: "event",
    title_it: "Il mondo di Escher",
    text_it: "
    !http://www.accademia-cappiello.it/images/old/escher.jpg!
    
    È stata prorogata fino al 6 gennaio 2011 la Mostra monografica di Maurits Cornelis Escher a cura della M.C. Escher Foundation che si è aperta il 2 settembre a UDINE 

    Famoso per le sue opere che fondono arte e pensiero scientifico, la mostra dedicata al maestro della grafica propone i lavori più noti e suggestivi di Escher. Le opere dell'artista olandese ci catapultano in un mondo in cui tempo e spazio si rincorrono senza soluzione di continuità piegandosi alla sua ciclicità visionaria.

    La mostra è ospitata negli spazi di Casa Colombatti - Cavazzini (futura Galleria d'Arte moderna di Udine), via Cavour, 14.

    Maggiori info sull' \"articolo di udinecultura.it\":http://www.udinecultura.it/opencms/opencms/release/ComuneUdine/cittavicina/cultura/news/2010/09/04.html",

    title_en: "Escher's World",
    text_en: "
    !http://www.accademia-cappiello.it/images/old/escher.jpg!
    
    It has been extended until January 6, 2011 the solo exhibition of Maurits Cornelis Escher by the MC Escher Foundation, which opened Sept. 2 in UDINE

    Famous for his works that merge art and scientific thought, the exhibition offers the master of graphic work of Escher most famous and beautiful. The works of Dutch artist catapult us into a world where time and space chasing seamless bowing to his visionary cyclicity.

    The exhibition is housed in the spaces of Casa Colombatti - Cavazzini (future Gallery of Modern Art in Udine, Italy), Via Cavour, 14.

    More info here",
  },
  {
    created_at: "05/11/2010",
    article_type: "event",
    title_it: "ARTISSIMA 17",
    text_it: "Da oggi al 7 novembre a Torino Artissima 17, internazionale d'Arte Contemporanea, Lingotto Fiere. Per la prima volta quest'anno una sezione interamente dedicata anche al design. www.artissima.it",

    title_en: "ARTISSIMA 17",
    text_en: "From now until November 7 in Turin, is open ARTISSIMA 17 International Fair of Contemporary Art at Lingotto Fiere. For the first time this year also a section dedicated to design. www.artissima.it",
  },
  {
    created_at: "24/08/2010",
    article_type: "event",
    title_it: "Graphic Design dal Giappone - 100 Poster 2001-2010",
    text_it: "    
    In mostra a Venezia i cento manifesti, selezionati tra migliaia di opere presentate ogni anno per l'assegnazione dei premi più prestigiosi, che rappresentano il meglio degli ultimi dieci anni di grafica giapponese.

    FONDAZIONE BEVILACQUA LA MASA  dal 27/08/10 al 17/10/10 - Venezia",

    title_en: "Graphic Design from Japan - 100 Poster 2001-2010",
    text_en: "This article is not available in english, please see the italian version.",
  },
]

articles.each do |article|
  Article.create article.merge(created_at: DateTime.parse(article[:created_at]))
end
