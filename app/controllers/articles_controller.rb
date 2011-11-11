class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = params[:id].inty? ? Article.get(params[:id]) : Article.first( "title_url_#{current_lang}".to_sym => params[:id])
    return not_found if @article.nil?
  end
  
  def new
    @article = Article.new
  end
  
  def create
    correct_date_params
    @article = Article.new(params[:article])
    if @article.save
      redirect_to @article, notice: "#{@article.tipo.capitalize} inserito/a!"
    else
      flash[:error] = "Errore nell'inserimento della news/evento"
      render :new
    end
  end
  
  def edit
    @article = Article.get(params[:id])
    return not_found if @article.nil?
  end
  
  def update
    correct_date_params
    @article = Article.get(params[:id])
    return not_found if @article.nil?
    if @article.update(params[:article])
      redirect_to @article, notice: "#{@article.tipo.capitalize} modificato/a!"
    else
      flash[:error] = "Errore nella modifica della news/evento"
      render :edit
    end
  end
  
  def destroy
    @article = Article.get(params[:id])
    return not_found if @article.nil?
    @article.destroy
    redirect_to root_path, notice: "#{@article.tipo.capitalize} eliminato/a!"
  end
  
  protected
  
  def correct_date_params
    obj = :article
    Article.properties.each do |prop|
      attr = prop.name.to_s
      if prop.class_name.to_s =~ /Date/
        year  = params[obj]["#{attr}(1i)"].to_i
        month = params[obj]["#{attr}(2i)"].to_i
        day   = params[obj]["#{attr}(3i)"].to_i
        params[obj].delete "#{attr}(1i)"
        params[obj].delete "#{attr}(2i)"
        params[obj].delete "#{attr}(3i)"
        params[obj][attr] = Date.new(year, month, day)
      end
    end
  end
  
end