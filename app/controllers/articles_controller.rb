class ArticlesController < ApplicationController

  def show
    @article = params[:id].inty? ? Article.get(params[:id]) : Article.first( "title_url_#{current_lang}".to_sym => params[:id])
    return not_found if @article.nil?
  end
  
  def new
    @article = Article.new
  end
  
  def create
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
  
end