class String
  def inty?
    self.to_i.to_s == self && self.to_i != 0
  end
end

class PagesController < ApplicationController
  def index
    params[:id] = "1"
    @page = Page.get(params[:id])
    @news = Article.news.all(limit: 6)
    @events = Article.events.all(limit: 6)
    raise NotFound if @page.nil?
    render :show
  end
  
  def show
    if ["l_accademia", "about_us", "1"].include? params[:id]
      redirect_to root_path; return 
    end
      
    @page = params[:id].inty? ? Page.get(params[:id]) : Page.first( "title_url_#{current_lang}".to_sym => params[:id])
    @user = current_user || User.new
    raise NotFound if @page.nil?
  end
  
  def edit
    @page = Page.get(params[:id])
    raise NotFound if @page.nil?
  end
  
  def update
    @page = Page.get(params[:id])
    raise NotFound if @page.nil?
    if @page.update(params[:page])
      redirect_to @page, notice: "Pagina modificata!"
    else
      flash[:error] = "I dati inseriti non sono sufficenti e/o corretti"
      render :edit
    end
  end
  
end