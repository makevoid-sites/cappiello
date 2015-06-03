class PagesController < ApplicationController

  after_filter :track_site, only: [:show]

  private

  def track_site(source = :organic, properties = {}) # add adwords id or fb id & info
    track "site_#{source}", properties
  end

  public

  def index
    params[:id] = "35"
    @page = Page.get(params[:id].to_i)
    load_news
    raise NotFound if @page.nil?

    source = :organic
    type = nil
    unless params[:source].blank?
      logger.info "advertising: { source: #{params[:source]}, type: #{params[:type]} }"
      source = params[:source]
      type = params[:type]
    end
    track_site source, { type: type }

    render :show
  end

  def show
    if home_page?
      redirect_to root_path; return
    end

    @page = params[:id].inty? ? Page.get(params[:id]) : Page.first( "title_url_#{current_lang}".to_sym => params[:id])
    @user = current_user || User.new

    raise NotFound if @page.nil?
    load_news if @page.id == 1

    track_page(:course) if @page.course?
  end

  def stats
    admin_only
  end

  def pdf
    logged_only
    UserMailer.send("admin_pdf", current_user, params[:name]).deliver
    current_user.pdfs_downloaded_add params[:name]
    raise NotFound if params[:name].blank?
    redirect_to "/pdf/#{params[:name]}.#{params[:format]}"
  end

  def pdf_en
    logged_only
    UserMailer.send("admin_pdf", current_user, params[:name]).deliver
    current_user.pdfs_downloaded_add params[:name]
    raise NotFound if params[:name].blank?
    redirect_to "/pdf/en/#{params[:name]}.#{params[:format]}"
  end

  def edit
    @page = Page.get(params[:id].to_i)
    raise NotFound if @page.nil?
  end

  def update
    @page = Page.get(params[:id].to_i)
    raise NotFound if @page.nil?
    if @page.update(params[:page])
      redirect_to @page, notice: "Pagina modificata!"
    else
      flash[:error] = "I dati inseriti non sono sufficenti e/o corretti"
      render :edit
    end
  end

  def load_news
    @news = Article.news.all(limit: 8).reverse
    @posts = Article.posts.all(limit: 8)
  end

  # static pages

  def offer

  end

  def cookies

  end

end
