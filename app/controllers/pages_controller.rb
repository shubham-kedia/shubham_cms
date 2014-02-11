class PagesController < ApplicationController
  
  layout "admin"

  def index
    @pages= Page.sorted
  end

  def show
    @page= Page.find(params[:id])
  end

  def new
    @page= Page.new()
  end

  def create
    if @page=Page.new(page_params).save
       flash[:notice] = "Page Created Succesfully."
       redirect_to(:action => 'index')
    end
  end

  

  def edit
     @page= Page.find(params[:id])
  end

  def update
    if @page=Page.find(params[:id]).update_attributes(page_params)
       flash[:notice] = "Page updated Succesfully."
       redirect_to(:action => 'show', :id => params[:id])
    else
       render('edit')
    end

  end


  def delete
     @page = Page.find(params[:id])
  end

  def destroy
     page = Page.find(params[:id]).destroy
     flash[:notice] = "Page '#{page.name}' Destroyed Succesfully."
     redirect_to(:action => 'index')
  end 

  private
    def page_params
      params.require(:page).permit(:name,:subject_id,:visible,:permalink,:position)
      
    end

end
