class WorksController < ApplicationController
  
  def index
    
  end
  
  def new
    
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def create
    if work.save
      redirect_to [:works], notice: "Lavoro inserito!" 
    else
      flash[:error] = "Errore nell'inserimento"
      render :new
    end
  end
  
  def update
    if work.update(params[:work])
      redirect_to work, notice: "Lavoro modificato!" 
    else
      flash[:error] = "Errore nella modifica"
      render :edit
    end
  end
  
  def destroy
    work.destroy
    redirect_to [:works], notice: "Lavoro cancellato!"
  end
  
  
  def works
    @works ||= Work.paginate(:page => params[:page] )
  end
  helper_method :works
  
  def work
    @works ||= params[:id] ? Work.get(params[:id]) : Work.new(params[:work])
  end
  helper_method :work
  # TODO: usare il controller sketch

end