class PagesController < ApplicationController
  
  layout "admin"
  
  before_action :confirm_logged_in
  before_action :find_subject
  def index
    # @pages= Page.where(:subject_id => @subject.id).sorted
    # or
    @pages = @subject.pages.sorted
  end

  def show
    @page= Page.find(params[:id])
  end

  def new
    @page= Page.new({:subject_id => @subject.id})
    @subjects= Subject.order('position ASC')
    @page_count = Page.count +1
  end

  def create
    if @page=Page.new(page_params).save
       flash[:notice] = "Page Created Succesfully."
       redirect_to(:action => 'index',:subject_id => @subject.id)
    else
       @subjects= Subject.order('position ASC')
       @page_count = Page.count +1
       render('new')
    end
  end

  

  def edit
     @page= Page.find(params[:id])
     @subjects= Subject.order('position ASC')
     @page_count = Page.count
  end

  def update
    if @page=Page.find(params[:id]).update_attributes(page_params)
       flash[:notice] = "Page updated Succesfully."
       redirect_to(:action => 'show', :id => params[:id], :subject_id => @subject.id)
    else
       @subjects= Subject.order('position ASC')
       @page_count = Page.count
       render('edit')
    end

  end


  def delete
     @page = Page.find(params[:id])
  end

  def destroy
     page = Page.find(params[:id]).destroy
     flash[:notice] = "Page '#{page.name}' Destroyed Succesfully."
     redirect_to(:action => 'index',:subject_id => @subject.id)
  end 

  private
    def page_params
      params.require(:page).permit(:name,:subject_id,:visible,:permalink,:position)
      
    end

    def find_subject
      if params[:subject_id]
        @subject = Subject.find(params[:subject_id])
      end
    end

end
