class SectionsController < ApplicationController
  layout "admin"

  before_action :confirm_logged_in
  
  def index
    @sections= Section.sorted
  end

  def show
    @section= Section.find(params[:id])
  end

  def new
    @section= Section.new()
  end

  def create
    if @section=Section.new(section_params).save
       flash[:notice] = "Section Created Succesfully."
       redirect_to(:action => 'index')
    end
  end

  

  def edit
     @section= Section.find(params[:id])
  end

  def update
    if @section=Section.find(params[:id]).update_attributes(section_params)
       flash[:notice] = "Section updated Succesfully."
       redirect_to(:action => 'show', :id => params[:id])
    else
       render('edit')
    end

  end


  def delete
     @section = Section.find(params[:id])
  end

  def destroy
     section = Section.find(params[:id]).destroy
     flash[:notice] = "Section '#{section.name}' Destroyed Succesfully."
     redirect_to(:action => 'index')
  end 

  private
    def section_params
      params.require(:section).permit(:name,:page_id,:visible,:permalink,:position,:content_type,:content)
      
    end

end
