class PhotosController < ApplicationController
  
  def index
    @photos = Photo.all
  end
  
  def show
    @photo = Photo.get(params[:id])
    return not_found if @photo.nil?
  end
  
  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      redirect_to [:photos], notice: "Foto caricata!"
    else
      flash[:error] = "Errore nel caricamento della foto"
      render :new  
    end
      
  end
  
  def destroy
    @photo = Photo.get(params[:id])
    return not_found if @photo.nil?
    @photo.destroy
    redirect_to [:photos], notice: "Foto cancellata!"
  end
  
end