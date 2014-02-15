class SectionsController < ApplicationController
  layout "admin"

  before_action :confirm_logged_in
  before_action :find_page
  def index
    # @sections= Section.where(:page_id => @page.id).sorted
    @sections= @page.sections.sorted
  end

  def show
    @section= Section.find(params[:id])
  end

  def new
    @section= Section.new({:page_id => @page.id})
    @pages= Page.order('position ASC')
    @section_count = Section.count +1
  end

  def create
    if @section=Section.new(section_params).save
       flash[:notice] = "Section Created Succesfully."
       redirect_to(:action => 'index',:page_id => page.id)
    else
      @section_count = Section.count +1
      render('new')
    end
  end

  

  def edit
     @section= Section.find(params[:id])
     @section_count = Section.count
  end

  def update
    if @section=Section.find(params[:id]).update_attributes(section_params)
       flash[:notice] = "Section updated Succesfully."
       redirect_to(:action => 'show', :id => params[:id],:page_id => page.id)
    else
      @section_count = Section.count
       render('edit')
    end

  end


  def delete
     @section = Section.find(params[:id])
  end

  def destroy
     section = Section.find(params[:id]).destroy
     flash[:notice] = "Section '#{section.name}' Destroyed Succesfully."
     redirect_to(:action => 'index',:page_id => page.id)
  end 

  private
    def section_params
      params.require(:section).permit(:name,:page_id,:visible,:permalink,:position,:content_type,:content)
    end
     def find_page
      if params[:page_id]
        @page = Page.find(params[:page_id])
      end
    end

end
