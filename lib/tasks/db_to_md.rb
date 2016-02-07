path = File.expand_path "../../../", __FILE__

require "#{path}/config/environment"

dir_path = "#{path}/db/pages"

`rm -rf #{dir_path}`
`mkdir -p #{dir_path}`

Page.all.each do |page|

  File.open("#{dir_path}/#{page.title_url_it}_it.md", "w") do |file|
    file.write page.text_it
  end

  File.open("#{dir_path}/#{page.title_url_en}_en.md", "w") do |file|
    file.write page.text_en
  end

  File.open("#{dir_path}/#{page.title_url_it}.saf", "w") do |file|
    file.write "
    id: #{page.id}
    ptype: #{page.ptype}
    master: #{page.master}
    position: #{page.position}
    int_name: #{page.int_name}
    hidden: #{page.hidden}
    parent_id: #{page.parent_id}
    title_it: #{page.title_it}
    meta_description_it: #{page.meta_description_it}
    meta_keywords_it: #{page.meta_keywords_it}
    title_url_it: #{page.title_url_it}
    title_en: #{page.title_en}
    meta_description_en: #{page.meta_description_en}
    meta_keywords_en: #{page.meta_keywords_en}
    title_url_en: #{page.title_url_en}
    ".gsub(/^\s\s\s\s/, '').strip
  end

end
