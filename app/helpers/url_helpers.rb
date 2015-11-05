module UrlHelpers
  def pag_path(page)
    id = page.is_a?(String) ? page : page.send("title_url_#{current_lang}")
    page_path id: id
  end

  def articl_path(article)
    type = article.article_type
    if article.is_a?(String)
      send "#{type}_path", { id: id }
    else
      cr8 = article.created_at
      send "#{type}_date_path", { id: article.send("title_url_#{current_lang}"), year: cr8.year, month: cr8.month, day: cr8.day }
    end
  end
end
