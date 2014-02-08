class PagesController < ApplicationController
  
  # GET /pages/home
  def home
    @filming_locations = {}
       
    respond_to do |format|
      format.html # home.html.erb
      format.json { render json: @filming_locations }
    end        
    
  end
  
end