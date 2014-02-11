class SubjectsController < ApplicationController
  
  layout "admin"

  def index
    @subjects=Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new()
  end

  def create
    # Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    # save objcet
    if @subject.save
      # save succes than redirect
      flash[:notice] = "Subject Created Succesfully."
      redirect_to(:action => 'index')
    else
      # save fails display the form again
      render('new')
    end

  end

  def edit
     @subject = Subject.find(params[:id])
  end
  def update
    # Find existing object using form parameters
    @subject = Subject.find(params[:id])
    # update object
    if  @subject.update_attributes(subject_params)
      # update succes than redirect
      flash[:notice] = "Subject updated Succesfully."
      redirect_to(:action => 'show', :id => @subject.id)
    else
      # update fails display the form again
      render('edit')
    end

  end

  def delete
     @subject = Subject.find(params[:id])
  end

  def destroy
     subject = Subject.find(params[:id]).destroy
     flash[:notice] = "Subject '#{subject.name}' Destroyed Succesfully."
     redirect_to(:action => 'index')
  end 

  private
    def subject_params
      # same as using "params[:subject]", except that it :
      # -r mass-assignedaises an error if :subject is not present
      # -allows listed attributes to be
      params.require(:subject).permit(:name, :position, :visible) 
    end

end
