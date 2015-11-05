class PagesNewController < ApplicationController
  def show
    render params[:id]
  end
end
